assert = require('chai').assert

AbstractArray = require '../lib/AbstractArray'

describe 'AbstractArray', ->
	
	describe 'mutators', ->
		
		it 'push', ->
			a = new AbstractArray()
			a.push('foo')
			assert.deepEqual a.getArray(), ['foo']
			o = {foo: 'bar'}
			a.push(o)
			assert.deepEqual a.getArray(), ['foo', o]
			assert.deepEqual a.getArray(), ['foo', {foo: 'bar'}]
			o.foo = 'bing'
			assert.deepEqual a.getArray(), ['foo', {foo: 'bing'}]
			assert.deepEqual a.getArray(), ['foo', o]
			
		it 'push & pop', ->
			a = new AbstractArray()
			p = a.pop()
			assert.equal p, undefined
			assert.deepEqual a.getArray(), []
			a.push('hello')
			p = a.pop()
			assert.equal p, 'hello'
			assert.deepEqual a.getArray(), []
			a.push('hello')
			a.push('again')
			p = a.pop()
			assert.equal p, 'again'
			assert.deepEqual a.getArray(), ['hello']
		
		
		
