module.exports = matcher =
	match: (pattern, string) ->
		j = 0
		patternCharCode = pattern.charCodeAt '0'
		strlen = string.length
		while j < strlen
			strChar = string.charCodeAt(j++)
			if @isUpper strChar then strChar += 32

			if strChar is patternCharCode then return true
		
		return false

	isUpper: (charCode) ->
		charCode > 64 and charCode < 91