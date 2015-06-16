module.exports = scorer = 
	score: (char, matchPos, previousCharPos) ->
		score = matchPos - previousCharPos
		score

	isUpper: (charCode) ->
		charCode > 64 and charCode < 91