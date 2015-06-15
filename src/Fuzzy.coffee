matcher = require './matcher'

module.exports = class Fuzzy
	constructor: ->
		@_items = [[]]
		@_currentPattern = ''

		@

	addItem: (item) ->
		@_items[0].push {text: item, score: 0, startPosition: 0}
		
		return

	filter: (newPattern) ->
		if newPattern is ''
			@_clearSearch()
			return []

		l = newPattern.length
		if newPattern > @_currentPattern
			pattern = newPattern.slice @_currentPattern.length, l
			for p in pattern
				strings = @_items[@_items.length - 1]
				result = @_items[@_items.length] = []
				for entry in strings
					if matcher.match(p, entry.text) then result.push entry
		
		output = []
		output.push r.text for r in result
		output

	_clearSearch: ->
		@_items.length = 1
		@_currentPattern = ''
		return

