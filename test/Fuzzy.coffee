Fuzzy = require '../src/Fuzzy'
assert = require 'assert'

fuzzy = new Fuzzy
strings = ['black', 'blake', 'blank']
fuzzy.addItem str for str in strings

describe 'Fuzzy', ->
	describe 'matcher', ->
		it 'pattern:b', ->
			res = fuzzy.filter 'b'
			assert.deepEqual res, ['black', 'blake', 'blank']

		it 'pattern:bc', ->
			res = fuzzy.filter 'bc'
			assert.deepEqual res, ['black']

		it 'pattern:\'\'', ->
			res = fuzzy.filter ''
			assert.deepEqual res, []