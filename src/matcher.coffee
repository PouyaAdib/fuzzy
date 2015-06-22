scorer = require './scorer'

module.exports = matcher =
	match: (pattern, string, startPosition) ->
		j = startPosition
		pattern = pattern.toLowerCase().charCodeAt '0'
		strlen = string.length
		while j < strlen
			str = string.charCodeAt(j++)
			if @isUpper str then str += 32
			if str is pattern then return {pos: j, score: scorer.score(j, startPosition)}

		-1

	isUpper: (charCode) ->
		charCode > 64 and charCode < 91