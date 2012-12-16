# GAPlugin

> Google Analytics plugin for iOS and Android. This allows you to post usage information to your Google Analytics account.


## Installation:

Follows the [Cordova Plugin spec](https://github.com/alunny/cordova-plugin-spec), and it works with [Pluginstall](https://github.com/alunny/pluginstall).

To install it to your app, simply execute pluginstall as follows:

	pluginstall [PLATFORM] [TARGET-PATH] [PLUGIN-PATH]

where:

* `[PLATFORM]` = ios or android
* `[TARGET-PATH]` = path to folder containing your phonegap project
* `[PLUGIN-PATH]` = path to folder containing this plugin

## Usage
The plugin creates the object `window.plugins.gaPlugin`

### Initializing

After onDeviceReady, create a local var and startup the plugin like so:

```javascript
var gaPlugin;
	
function onDeviceReady() {
	gaPlugin = window.plugins.gaPlugin;
	gaPlugin.init(successHandler, errorHandler, "UA-12345678-1", 10);
}
```

To get things rolling you need to call init() when your device ready function fires.
Init takes 4 arguments:

 1. success - a function that will be called on success
 1. fail - a function that will be called on error.
 1. id - Your Google Analytics account ID of the form; UA-XXXXXXXX-X<br/>This is the account ID you were given when you signed up.
 1. period - An integer containing the minimum number of seconds between upload of metrics. When metics are logged, they are enqued and are sent out in batches based on this value. You'll want to avoid setting this value too low, to limit the overhead of sending data.

Ex: 

```javascript
gaPlugin.init(successHandler, errorHandler, "UA-12345678-1", 10);
```

### Tracking Events

To track an event, call (oddly enough) trackEvent().
trackEvent takes 6 arguments;

 1. resultHandler - a function that will be called on success
 1. errorHandler - a function that will be called on error.
 1. category - This is the type of event you are sending such as "Button", "Menu", etc.
 1. eventAction - This is the type of event you are sending such as "Click", "Select". etc.
 1. eventLabel - A label that describes the event such as Button title or Menu Item name.
 1. eventValue - An application defined integer value that can mean whatever you want it to mean.
	
Ex:

```javascript
gaPlugin.trackEvent( nativePluginResultHandler, nativePluginErrorHandler, "Button", "Click", "event only", 1);
```
### Setting Arbitrary Data

TrackEvent covers most of what you need, but there may be cases where you want to pass arbitrary data.
setVariable() lets you pass key/value pairs (Up to 4 on free accounts, up to 50 on paid accounts).
For free accounts, each variable is given an index from 1 - 4. (1 - 50 for paid). Reusing an existing index simply overwrites
the previous value. Passing an index out of range fails silently, with no data sent. The variables will be sent ONLY for the next
trackEvent, after which those indexes will be available for reuse.
setVariable() accepts 5 arguments;

 1. resultHandler - a function that will be called on success
 1. errorHandler - a function that will be called on error.
 1. key - this is the identifying key for the value you are passing.
 1. value - Arbitrary string data associated with the key and index.
 1. index - the numerical index representing on of your variable slots (1-4 or 1-50, depending on the account type)

Ex:

```javascript
gaPlugin.setVariable( nativePluginResultHandler, nativePluginErrorHandler, "favoriteColor", "Purple", 1);
```

### Tracking Pages

In addition to events and variables, you can also log page visits with trackPage(). Unlike variables, howver, page hits do not require
a subsequent call to trackEvent() as they are considered unique events in and of themselves.
trackPage() takes 3 arguments;

 1. resultHandler - a function that will be called on success
 1. errorHandler - a function that will be called on error.
 1. url - The url of the page hit you are logging.

Ex:

```javascript
gaPlugin.trackPage( nativePluginResultHandler, nativePluginErrorHandler, "some.url.com");
```

### Shutting Down

Finally, when your app shuts down, you'll want to cleanup after yourselve by calling exit();
exit() accepts 2 arguments;

 1. resultHandler - a function that will be called on success
 1. errorHandler - a function that will be called on error.

Ex:

```javascript
gaPlugin.exit(nativePluginResultHandler, nativePluginErrorHandler);
```

This package includes an Example folder containing an index.html file showing how all of this fits together.
Note that the contents of Examples does not get installed anywhere by pluginstall. Its just there to provide a usage example.

## More Info
	
GAPlugin includes libraries from Google Analytics SDK for iOS and for Android.
Use of those libraries is subject to [Google Analytics Terms of Service](http://www.google.com/analytics/terms/us.html)
	
Also take a look at [Google Analytics Developer Guides](https://developers.google.com/analytics/devguides/)

## License ##

The MIT License

Copyright (c) 2012 Bob Easterday, Adobe Systems

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
