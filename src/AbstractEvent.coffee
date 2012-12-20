###
#
# A general event object, e.g. for passing to handlers.
# Useful for event logic, passing to handlers to expose behaviors
# like preventing defaults, etc.
# 
# Where appropriate, modelled after the W3C DOM Event interface.
# @see http://www.w3.org/TR/DOM-Level-3-Events/
# @see https://developer.mozilla.org/en-US/docs/DOM/event
# 
###
class AbstractEvent
	constructor: (options) ->
		@type = options.type
		@timeStamp = new Date()
		@defaultPrevented = false
	
	preventDefault: ->
		@defaultPrevented = true

module.exports = AbstractEvent
