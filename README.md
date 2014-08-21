# EventedArray

An evented wrapper around the native JavaScript Array for Node.js.

Uses [EventEmitter2][].

## Usage

Bind to "before.*" and "after.*" events on an instance of EventedArray to listen for any of the Array prototype method calls.

The major quirk is that getting and setting array values must be done with helper methods, since we can't use the regular bracket indexing syntax with our wrapper.

```js
ea = new EventedArray();
ea.set(0, 'first');
ea.get(0); // === 'first'
ea.getArray(); //  [0]
ea.setArray(['new','one']);
ea.getArray(); //  ['new','one']
ea.get(1); // === 'one'

ea.once('before.set', function (e, value) {
	console.log(value);
});

ea.set(1); // === 'fun'
// > 'fun'

ea.getArray(); //  ['new','fun']

ea.on('before.set', function (e, value) {
	e.preventDefault();
	console.log('default prevented');
});

ea.set(0, 'so');
// > 'default prevented'

ea.get(0); // === ['new']

```

See the tests for more usage examples.

[EventEmitter2]: https://github.com/hij1nx/EventEmitter2 "EventEmitter2"


