
#macro MLDTK_FILE_NAME "LDtkTest.ldtk"

globalvar MLDTK_DATA;

function MLdtk_start(_enums = { DebugEnums: { normal: 0, debug: 1 } }) {
	LDtkConfig({ file: MLDTK_FILE_NAME });
	LDtkMappings({ enums : _enums });
	
	var file = global.__ldtk_config.file
	if (!file_exists(file)) {
		show_message("Cannot find " + file);
		game_end();
	}
	
	var buffer = buffer_load(file);
	var json = buffer_read(buffer, buffer_string);
	buffer_delete(buffer);
	
	MLDTK_DATA = json_parse(json);
}

function MLdtk_load(_level_name = room_get_name(room)) {
	
	var config = global.__ldtk_config
	
	var level = undefined;
	var flag = 0;
	
	for(var i = 0; i < array_length(MLDTK_DATA.levels); ++i) {
		var _level = MLDTK_DATA.levels[i];
		if(_level_name = _level.identifier) {
			flag = 1;
			level = _level;
			break;
		}
	}
	
	if(!flag) {
		__LDtkTrace(_level_name, "not found, stop load!");
		return -1;
	}
	
	room_set_width(room, level.pxWid);
	room_set_height(room, level.pxHei);
	
	#region Handle layers

	var created_entities = []; // an array of { inst, object_id }
	var entity_references = {};
	var entity_refs = []; // an array of { inst, field_name, ref }
	
	for(var i = 0; i < array_length(level.layerInstances); i++) {
		var this_layer = level.layerInstances[i];
		var layer_type = this_layer.__type;
		
		#region Map the layer name
		
		var layer_name = this_layer.__identifier;
		if(!layer_exists(layer_name)) layer_create(i * 100, layer_name);
		var layer_id = layer_get_id(layer_name);
		
		#endregion
		
		#region Potentially ignoring the layer
		
		if (layer_id == -1 and layer_type != "IntGrid") {
			__LDtkTrace(layer_name, "not found, ignoring layer!");
			continue;
		}
		
		#endregion
		
		switch(layer_type) {
			
			#region Entity Layers
			
			case "Entities": // instances
				var tile_size = this_layer.__gridSize; // for scaling
				
				// for every entity in the level
				for(var e = 0; e < array_length(this_layer.entityInstances); ++e) {
					var entity = this_layer.entityInstances[e];
					var obj_name = entity.__identifier;
					
					#region Match with a GM object
					
					var object_id = asset_get_index(obj_name);
					if (object_id == -1) {
						__LDtkTrace("object/entity", obj_name, "not found in GM, ignoring!");
						continue;
					}
					
					#endregion
					
					#region Create the instance
					
					var _x = entity.px[0] + this_layer.__pxTotalOffsetX;
					var _y = entity.px[1] + this_layer.__pxTotalOffsetY;
					
					var inst = instance_create_layer(_x, _y, layer_id, oEmpty);
					array_push(created_entities, { inst, object_id, fields: undefined });
					
					// add to entity_reference
					entity_references[$ entity.iid] = inst;
					
					#endregion
					
					#region Set the scale
					
					var spr = object_get_sprite(object_id);
					if (sprite_exists(spr)) {
						inst.image_xscale = entity.width / sprite_get_width(spr);
						inst.image_yscale = entity.height / sprite_get_height(spr);
					}
					else {
						inst.image_xscale = 1;
						inst.image_yscale = 1;
					}
					
					#endregion
					
					#region Load the fields
					
					var fields_struct = {};
					
					// for each field of the entity
					for(var f = 0; f < array_length(entity.fieldInstances); ++f) {
						var field = entity.fieldInstances[f];
						
						var field_name = field.__identifier;
						var field_value = field.__value;
						var field_type = field.__type;
						
						#region Prepare the value
						
						// some types require additional work
						switch(field_type) {
							case "Point":
								field_value = __LDtkPreparePoint(field_value, tile_size);
								break
							case "Array<Point>":
								for(var j = 0; j < array_length(field_value); j++) {
									field_value[@ j] = __LDtkPreparePoint(field_value[j], tile_size);
								}
								break
							case "Color": // colors should be actual colors
								field_value = __LDtkPrepareColor(field_value);
								break
							case "Array<Color>":
								for(var j = 0; j < array_length(field_value); j++) {
									field_value[@ j] = __LDtkPrepareColor(field_value[j]);
								}
								break
							case "EntityRef":
								array_push(entity_refs, { inst, field_name, ref: field_value.entityIid });
								field_value = noone;
								break
							default:
								if(string_pos("LocalEnum", field_type)) {
									var enum_name_idx = string_pos(".", field_type);
									var enum_name_len = string_length(field_type);
									var enum_name = string_copy(field_type, enum_name_idx+1, 999);
									if (string_pos("Array<", field_type)) {
										enum_name = string_replace(enum_name, ">", "");
										for(var j = 0; j < array_length(field_value); j++) {
											field_value[@ j] = __LDtkPrepareEnum(enum_name, field_value[j]);
										}
									} else {
										field_value = __LDtkPrepareEnum(enum_name, field_value);
									}
								} else {
									field_value = field_value;
								}
								break
						}
						
						#endregion
						
						// set the value
						variable_struct_set(fields_struct, field_name, field_value);
					}
					
					if (config.escape_fields) {
						inst.__ldtk_fields = fields_struct;
					}
					
					array_last(created_entities).fields = fields_struct;
					
					#endregion
					
					__LDtkTrace("Loaded Entity! GM instance id=%", inst);
				}
				
				__LDtkTrace("Loaded an Entities Layer! name=%, gm_name=%", layer_name, layer_name);
				break;
				
			#endregion
			
			#region IntGrid Layers
			
			case "IntGrid":
				
				var csv_array = this_layer.intGridCsv;
				var cwid = this_layer.__cWid;
				var chei = this_layer.__cHei;
				
				var grid = new LDtkIntGrid(csv_array, cwid, chei);
				
				var grid_name = layer_name;
				
				global.ldtk_intgrids[? grid_name] = grid;
				
				__LDtkTrace("Loaded IntGrid! name=%, gm_name=%", layer_name, grid_name);
				
				if(array_length(this_layer.autoLayerTiles) > 0) { // same as tiles
					var tilemap = layer_tilemap_get_id(layer_id);
				
					cwid = this_layer.__cWid;
					chei = this_layer.__cHei;
				
					var tileset_def = undefined;
					var found_tileset_def = false;
					for(var ts = 0; ts < array_length(MLDTK_DATA.defs.tilesets); ++ts) {
						tileset_def = MLDTK_DATA.defs.tilesets[ts];
						if(tileset_def.uid == this_layer.__tilesetDefUid) {
							found_tileset_def = true;
							break;
						}
					}
					if(!found_tileset_def) break;
				
					tile_size = this_layer.__gridSize;
					
					var tileset_name = tileset_def.identifier;
					var tileset_id = asset_get_index(tileset_name);
					if(tileset_id == -1) break;
					tile_columns = tile_size / tileset_get_info(tileset_id).tile_columns;
					
					if (tilemap == -1) {
						tilemap = layer_tilemap_create(layer_id,
						this_layer.__pxTotalOffsetX, this_layer.__pxTotalOffsetY,
						tileset_id, cwid, chei);
						
					} else {
						tilemap_set_width(tilemap, cwid);
						tilemap_set_height(tilemap, chei);
						if(config.clear_timemaps) tilemap_clear(tilemap, 0);
						tilemap_x(tilemap, this_layer.__pxTotalOffsetX);
						tilemap_y(tilemap, this_layer.__pxTotalOffsetY);
					}
					
					for(var t = 0; t < array_length(this_layer.autoLayerTiles); ++t) {
						var this_tile = this_layer.autoLayerTiles[t];
						var tile_id =
						this_tile.src[0] / tile_size +
						this_tile.src[1] / tile_columns;
						tile_id = tile_set_mirror(tile_id, this_tile.f & 1);
						tile_id = tile_set_flip(tile_id, this_tile.f & 2);
						tilemap_set(tilemap, tile_id,
						this_tile.px[0] div tile_size, this_tile.px[1] div tile_size);
					}
					__LDtkTrace("Loaded a AutoTile Layer! name=%", layer_name);
				}
				
				break;
				
			#endregion
				
			#region AutoLayers
			
			case "AutoLayer":
				__LDtkTrace("AutoLayers are ignored")
				break
				
			#endregion
			
			#region Tile Layers
			
			case "Tiles": // tile map!
				var tilemap = layer_tilemap_get_id(layer_id);
				
				// this is the layers's size in cells
				cwid = this_layer.__cWid;
				chei = this_layer.__cHei;
				
				// find the tileset definition
				var tileset_def = undefined;
				var found_tileset_def = false;
				for(var ts = 0; ts < array_length(MLDTK_DATA.defs.tilesets); ++ts) {
					tileset_def = MLDTK_DATA.defs.tilesets[ts];
					
					if(tileset_def.uid == this_layer.__tilesetDefUid){
						found_tileset_def = true;
						break;
					}
				}
				if(!found_tileset_def) break;
				
				tile_size = this_layer.__gridSize;
				
					
				var tileset_name = tileset_def.identifier;
				var tileset_id = asset_get_index(tileset_name);
				if(tileset_id == -1) break;
				tile_columns = tile_size / tileset_get_info(tileset_id).tile_columns;
					
				// create tilemap if it doesn't exist on the layer
				if (tilemap == -1) {
					
					tilemap = layer_tilemap_create(layer_id,
					this_layer.__pxTotalOffsetX, this_layer.__pxTotalOffsetY,
					tileset_id, cwid, chei);
					
				} else { // the tilemap is already there
					// resize it
					tilemap_set_width(tilemap, cwid);
					tilemap_set_height(tilemap, chei);
					
					// clear of any remaining tiles
					if(config.clear_timemaps) tilemap_clear(tilemap, 0);
					
					// respect layer offsets
					tilemap_x(tilemap, this_layer.__pxTotalOffsetX);
					tilemap_y(tilemap, this_layer.__pxTotalOffsetY);
				}
				
				for(var t = 0; t < array_length(this_layer.gridTiles); ++t) {
					var this_tile = this_layer.gridTiles[t];
					
					var tile_id =
					this_tile.src[0] / tile_size +
					this_tile.src[1] / tile_columns;
					tile_id = tile_set_mirror(tile_id, this_tile.f & 1);
					tile_id = tile_set_flip(tile_id, this_tile.f & 2);
					
					tilemap_set(tilemap, tile_id,
					this_tile.px[0] div tile_size, this_tile.px[1] div tile_size);
				}
				
				__LDtkTrace("Loaded a Tile Layer! name=%", layer_name);
				break
				
			#endregion
			
			default:
				__LDtkTrace("warning! undefined layer type! (%)", this_layer.__type);
				break;
		}
	}
	
	#endregion
	
	#region A workaround for entity fields
	
	#region instance_change() + set most variables
	
	for(var j = 0; j < array_length(created_entities); ++j) {
		var entity = created_entities[j];
		var inst = entity.inst;
		var object_id = entity.object_id;
		var fields = entity.fields;
		
		with(inst) instance_change(object_id, false);
		
		#region Set all entity fields/instace variables
		
		var field_names = struct_get_names(fields);
		var field_names_len = struct_names_count(fields);
		for(var k = 0; k < field_names_len; ++k) {
			var field_name = field_names[k];
			var field_value = fields[$ field_name];
			variable_instance_set(inst, field_name, field_value);
		}
		
		#endregion
	}
	
	#endregion
	
	#region Resolve entity ref fields
	
	for (var j = 0; j < array_length(entity_refs); ++j) {
		var entity_ref = entity_refs[j];
		var gm_inst = entity_ref.inst;
		var target_field = entity_ref.field_name;
		
		var entity_ref_inst = entity_references[$ entity_ref.ref];
					
		variable_instance_set(gm_inst, target_field, entity_ref_inst);
		variable_struct_set(gm_inst.__ldtk_fields, target_field, entity_ref_inst);
	}
	
	#endregion
	#region Trigger the Create events
	
	for(var j = 0; j < array_length(created_entities); ++j) {
		var entity = created_entities[j];
		var inst = entity.inst;
		
		with(inst) {
			event_perform(ev_create, 0);
		}
	}
	
	#endregion
	
	#endregion
	
	return 0;
}





