///@function token_equals(token1, token2)
///@arg token1
///@arg token2
function token_equals(_token1, _token2) {
	return (
	_token1[Token.TYPE] == _token2[Token.TYPE] &&
	_token1[Token.VALUE] == _token2[Token.VALUE])
	
}
