module.exports = scorer = 
	score: (char, matchPos, previousCharPos) ->
		score = 20
		if @isUpper char
			score -= 1
		else
			if previousCharPos isnt -1 then score += matchPos - previousCharPos
		score

	isUpper: (charCode) ->
		charCode > 64 and charCode < 91