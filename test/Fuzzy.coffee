assert = require 'assert'
Fuzzy = require '../src/Fuzzy'
patternDistance = require "../src/patternDistance"

describe 'Fuzzy', ->
	describe 'sorter', ->
		fuzzy = new Fuzzy
		strings = ['abcd', 'acdb', 'adbc', 'eabc']
		fuzzy.addItem str for str in strings
		
		it 'ad', ->
			res = fuzzy.filter 'ad'
			assert.deepEqual res, ['adbc', 'acdb', 'abcd']

	describe 'scorer', ->
		fuzzy = new Fuzzy
		strings = ['black', 'bulk', 'Banana', 'Buzz Aldrin']
		fuzzy.addItem str for str in strings

		it 'pattern: ba', ->
			res = fuzzy.filter 'ba'
			assert.deepEqual res, ['Banana', 'black', 'Buzz Aldrin']

		it 'pattern: BA', ->
			res = fuzzy.filter 'BA'
			assert.deepEqual res, ['Banana', 'black', 'Buzz Aldrin']

	describe 'matcher', ->
		fuzzy = new Fuzzy
		strings = ['black', 'blake', 'blank']
		fuzzy.addItem str for str in strings
		
		it 'pattern:b', ->
			res = fuzzy.filter 'b'
			assert.deepEqual res, ['black', 'blake', 'blank']

		it 'pattern:bc', ->
			res = fuzzy.filter 'bc'
			assert.deepEqual res, ['black']

		it 'pattern:\'\'', ->
			res = fuzzy.filter ''
			assert.deepEqual res, []

		it 'pattern:ke', ->
			res = fuzzy.filter 'ke'
			assert.deepEqual res, ['blake']

		it 'pattern:black', ->
			res = fuzzy.filter 'black'
			assert.deepEqual res, ['black']

describe 'Pattern Distance', ->
	it '(abcd, ab) -> ([c, d], [])', ->
		dist = patternDistance.calculate 'abcd', 'ab'
		assert.deepEqual dist, [['c', 'd'], []]

	it '(abcd, abcd) -> ([], [])', ->
		dist = patternDistance.calculate 'abcd', 'abcd'
		assert.deepEqual dist, [[], []]

	it '(abcd, abfg) -> ([c, d], [f, g])', ->
		dist = patternDistance.calculate 'abcd', 'abfg'
		assert.deepEqual dist, [['c', 'd'], ['f', 'g']]

	it '(abcd, abcde) -> ([], [e])', ->
		dist = patternDistance.calculate 'abcd', 'abcde'
		assert.deepEqual dist, [[], ['e']]

	it '(ke, black) -> ([k, e], [b, l, a, c, k])', ->
		dist = patternDistance.calculate 'ke', 'black'
		assert.deepEqual dist, [['k', 'e'], ['b', 'l', 'a', 'c', 'k']]