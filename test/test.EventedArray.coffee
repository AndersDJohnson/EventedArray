assert = require('chai').assert

EventedArray = require '../lib/EventedArray'

describe 'EventedArray', ->
	
	describe 'events', ->
		
		it 'before.set', () ->
			a = new EventedArray()
			
			a.set(0, 'hello')
			a.once 'before.set', (e, index, value) ->
				e.preventDefault()
				assert.equal index, 0
				assert.equal value, 'goodbye'
			a.set(0, 'goodbye')
			assert.equal a.get(0), 'hello'
			assert.equal a.getArray()[0], 'hello'
			
		
		it 'before.push', () ->
			a = new EventedArray()
			
			a.once 'before.push', ->
				throw new Error('before.push')
			assert.throws((->
				a.push('hi')
			), /before\.push/)
			assert.deepEqual a.getArray(), []
			
			i = 0
			callback = (e, arg) ->
				assert.equal arg, 'pushing' + i
				i++
			a.on 'before.push', callback
			a.push('pushing' + i)
			a.push('pushing' + i)
			a.push('pushing' + i)
			a.off 'before.push', callback
			a.push('foo')
		
		it 'preventable', ->
			a = new EventedArray()
			a.push('one')
			callback = (e) ->
				e.preventDefault()
			a.on 'before.push', callback
			a.push 'nope'
			a.push 'fail'
			a.off 'before.push', callback
			a.push 'two'
			assert.deepEqual a.getArray(), ['one', 'two']
		
	

