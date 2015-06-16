sorter = require './sorter'
scorer = require './scorer'
matcher = require './matcher'
patternDistance = require './patternDistance'

module.exports = class Fuzzy
	constructor: ->
		@_items = [[]]
		@_currentPattern = ''
		@

	addItem: (item) ->
		@_items[0].push {text: item, score: 0, startPosition: 0}		
		return

	filter: (newPattern) ->
		distance = patternDistance.calculate @_currentPattern, newPattern
		@_currentPattern = newPattern

		@_popInvalidResults distance[0]
		@_pushNewResults distance[1]
		@_outputResult()

	_popInvalidResults: (deletions) ->
		l = deletions.length
		if l is 0 then return
		until l-- is 0 then @_items.pop()
		return

	_pushNewResults: (insertions) ->
		l = insertions.length
		if l is 0 then return
		i = -1
		until ++i is l
			itemsLength = @_items.length
			strings = @_items[itemsLength - 1]
			result = @_items[itemsLength] = []
			for entry in strings
				match = matcher.match(insertions[i], entry.text, entry.startPosition)
				if match
					score = scorer.score match - 1, entry.startPosition - 1
					result.push {text: entry.text, score: score, startPosition: match}
		sorter.sort result
		return

	_outputResult: ->
		output = []
		result = @_items[@_items.length - 1]
		output.push r.text for r in result
		output
