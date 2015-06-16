module.exports = sorter = 
	sort: (array) ->
		array.sort (a,b) -> a.score - b.score
		sortedTexts = []
		sortedTexts.push a.text for a in array
		sortedTexts