class AbstractArray
	
	###
	# @see https://developer.mozilla.org/en-US/docs/JavaScript/Reference/Global_Objects/Array/prototype#Methods
	###
	@wrappedArrayMethods = [
		'pop'
		'push'
		'reverse'
		'shift'
		'sort'
		'splice'
		'unshift'
		'concat'
		'join'
		'slice'
		'toSource'
		'toString'
		'indexOf'
		'lastIndexOf'
		'forEach'
		'every'
		'some'
		'filter'
		'map'
		'reduce'
		'reduceRight'
	]
	
	constructor: ->
		@_array = []
	
	length: ->
		return @_array.length
	
	set: (index, value) ->
		return @_array[index] = value
	
	get: (index) ->
		return @_array[index]
	
	setArray: (newArray) ->
		unless typeof newArray is 'object'
			@_array = newArray
	
	getArray: (copy = true) ->
		if copy is false
			return @_array
		else
			return @_array.slice()


for method in AbstractArray.wrappedArrayMethods
	AbstractArray::[method] = ((meth) ->
		return ->
			args = Array::slice.call(arguments)
			return @_array[meth].apply(@_array, args)
	)(method)


module.exports = AbstractArray
