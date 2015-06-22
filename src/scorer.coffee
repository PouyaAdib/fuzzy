module.exports = scorer =
	score: (matchPos, previousCharPos) ->
		score = matchPos - previousCharPos
