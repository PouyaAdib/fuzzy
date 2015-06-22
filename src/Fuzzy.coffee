sorter = require './sorter'
matcher = require './matcher'
patternDistance = require './patternDistance'

module.exports = class Fuzzy
	constructor: ->
		@_items = [[]]
		@_results =[[]]
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
		until l-- is 0
			@_items.pop()
			@_results.pop()
		
		return

	_pushNewResults: (insertions) ->
		l = insertions.length
		if l is 0 then return
		i = -1
		until ++i is l
			itemsLength = @_items.length
			strings = @_items[itemsLength - 1]
			result = @_items[itemsLength] = []
			char = insertions[i]
			
			for entry in strings
				res = matcher.match(char, entry.text, entry.startPosition)
				if res isnt -1 
					result.push {text: entry.text, score: entry.score + res.score, startPosition: res.pos}
		
		@_results.push sorter.sort result
		
		return

	_outputResult: ->
		@_results[@_results.length - 1]
