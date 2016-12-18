# Changelog
This file contains highlights of what changes on each version of the [Akismet for Dart](https://github.com/cedx/akismet.dart) library.

#### Version 0.6.1
- Fixed bugs in `async` / `await` implementation.
- Fixed bugs in JSON serialization.

## Version 0.6.0
- Added the `role` property to `Author` class.
- Added the `isTest` property to `Client` class.
- Added the `date` and `postModified` properties to `Comment` class.
- Moved the `Future` API to `async` and `await`.

## Version 0.5.1
- Using [Gulp.js](http://gulpjs.com) as build system.

## Version 0.5.0
- Breaking change: renamed `Server.start` method to `bind`.
- Added `Server.bindSecure` method to support SSL protocol.
- Updated the package dependencies.

## Version 0.4.0
- Moved most methods and properties of `Client` child classes to the base abstract class.
- Added `Blog` class to support the latest Akismet APIs.
- Added `Server` events: you can listen to `onClose`, `onError`, `onListening` and `onRequest` streams.
- Added `--silent` option to server CLI.
- Breaking change: renamed `Server.stop` method to `close`.
- Breaking change: renamed `HTTPHeaders` constants by using `X_` as prefix.
- Breaking change: removed `Client.useSecureRequests` property.

## Version 0.3.2
- Migrated build system and tools to [ShellJS](http://shelljs.org).
- Migrated documentation comments to [YUIDoc](http://yui.github.io/yuidoc).
- Using DocGen.js to generate the [API reference](https://cedx.github.io/akismet.dart).

## Version 0.3.1
- Added unit tests of the HTML client.
- The `Server` class and CLI now use port 3000 as default.

## Version 0.3.0
- Removed obsolete build scripts (`build.dart` and `tool/generate_docs.dart`).

## Version 0.2.1
- Added new properties and methods to `Server` class.
- Added utility scripts in `tool` folder.
- Changed the package layout.
- Breaking change: renamed `Server.secureRequests` property to `useSecureRequests`.

## Version 0.2.0
- Added client implementation based on [dart:html](https://api.dartlang.org/stable/dart-html/dart-html-library.html).
- Added server implementation used to proxy requests from HTML clients to [Akismet](https://akismet.com) service.
- Breaking change: `Uri` in constructors can no longer be specified as `String`.
- Breaking change: removed `Client.encoding` property.

## Version 0.1.1
- Added `EndPoints` class providing the URLs of the [Akismet](https://akismet.com) service end points.

## Version 0.1.0
- Initial release: client implementation based on [dart:io](https://api.dartlang.org/stable/dart-io/dart-io-library.html).
