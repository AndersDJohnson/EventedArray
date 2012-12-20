EventEmitter2 = require('eventemitter2').EventEmitter2

AbstractArray = require './AbstractArray'
AbstractEvent = require './AbstractEvent'

class EventedArray extends AbstractArray
	
	###
	# @see https://github.com/hij1nx/EventEmitter2/blob/master/README.md#api
	###
	@wrappedEventEmitter2Methods = [
		'addListener'
		'on'
		'onAny'
		'offAny'
		'once'
		'many'
		'removeListener'
		'off'
		'removeAllListeners'
		'setMaxListeners'
		'listeners'
		'listenersAny'
		'emit'
	]
	
	constructor: ->
		super
		@_emitter = new EventEmitter2 {
			wildcard: false
			newListener: false
			maxListeners: 0
		}
	
	set: (index, value) ->
		ret = undefined
		args = Array::slice.call(arguments)
		e1type = 'before.set'
		e1 = new AbstractEvent({type: e1type})
		@_emitter.emit.apply @_emitter, [e1type, e1].concat(args)
		unless e1.defaultPrevented
			ret = @_array[index] = value
		e2type = 'after.set'
		e2 = new AbstractEvent({type: e2type})
		@_emitter.emit.apply @_emitter, [e2type, e2].concat(args)
		return ret
	
	get: (index) ->
		ret = undefined
		args = Array::slice.call(arguments)
		e1type = 'before.get'
		e1 = new AbstractEvent({type: e1type})
		@_emitter.emit.apply @_emitter, [e1type, e1].concat(args)
		unless e1.defaultPrevented
			ret = @_array[index]
		e2type = 'after.get'
		e2 = new AbstractEvent({type: e2type})
		@_emitter.emit.apply @_emitter, [e2type, e2].concat(args)
		return ret


for method in EventedArray.wrappedEventEmitter2Methods
	EventedArray::[method] = ((meth) ->
		return ->
			args = Array::slice.call(arguments)
			return @_emitter[meth].apply(@_emitter, args)
	)(method)


for method in AbstractArray.wrappedArrayMethods
	EventedArray::[method] = ((meth) ->
		return ->
			ret = undefined
			args = Array::slice.call(arguments)
			e1type = 'before.' + meth
			e1 = new AbstractEvent({type: e1type})
			@_emitter.emit.apply @_emitter, [e1type, e1].concat(args)
			unless e1.defaultPrevented
				ret = @_array[meth].apply(@_array, args)
			e2type = 'after.' + meth
			e2 = new AbstractEvent({type: e2type})
			@_emitter.emit.apply @_emitter, [e2type, e2].concat(args)
			return ret
	)(method)


module.exports = EventedArray
