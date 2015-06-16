module.exports = patternDistance =
	calculate: (pattern1, pattern2) ->
		pattern1 = pattern1.split('')
		pattern2 = pattern2.split('')

		l = pattern1.length
		until l-- is 0
			if pattern1[0] is pattern2[0]
				pattern1.shift()
				pattern2.shift()
			else break

			if pattern2.length is 0 then break

		[pattern1, pattern2]