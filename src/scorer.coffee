module.exports = scorer = 
	score: (matchPos, previousCharPos) ->
		if previousCharPos is -1 then return 0
		matchPos - previousCharPos