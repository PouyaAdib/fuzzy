module.exports = sorter = 
	sort: (array) ->
		array.sort (a,b) -> a.score - b.score