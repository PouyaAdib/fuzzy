module.exports = matcher =
	match: (pattern, string, startPosition) ->
		j = startPosition
		patternCharCode = pattern.toLowerCase().charCodeAt '0'
		strlen = string.length
		while j < strlen
			strLowerChar = strChar = string.charCodeAt(j++)
			if @isUpper strChar then strLowerChar = strChar + 32

			if strLowerChar is patternCharCode then return {isMatch: yes, pos: j, charCode: strChar}

		return {isMatch: no}

	isUpper: (charCode) ->
		charCode > 64 and charCode < 91