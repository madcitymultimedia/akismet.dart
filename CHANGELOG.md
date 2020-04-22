# Changelog

## Version [4.0.1](https://git.belin.io/cedx/akismet.dart/compare/v4.0.0...v4.0.1)
- Fixed the [issue #1](https://git.belin.io/cedx/akismet.dart/issues/1): the `recheck_reason` field is not sent.

## Version [4.0.0](https://git.belin.io/cedx/akismet.dart/compare/v3.2.0...v4.0.0)
- Breaking change: starting to use and support the [Dart 2 SDK](https://dart.dev/tools/sdk).
- Added support for the `X-akismet-pro-tip` HTTP header.
- Added the `CheckResult` enumeration.
- Added the `ClientException` class.
- Added the `Comment.recheckReason` property.
- Added a user guide based on [MkDocs](http://www.mkdocs.org).
- Added an example code.
- Using optional `const` and `new`.
- Updated the package dependencies.

## Version [3.2.0](https://git.belin.io/cedx/akismet.dart/compare/v3.1.0...v3.2.0)
- Added support for browser platform.

## Version [3.1.0](https://git.belin.io/cedx/akismet.dart/compare/v3.0.0...v3.1.0)
- Updated the package dependencies.

## Version [3.0.0](https://git.belin.io/cedx/akismet.dart/compare/v2.1.0...v3.0.0)
- Breaking change: changed the signature of most class constructors.
- Breaking change: most class properties are now `final`.
- Breaking change: raised the required [Dart](https://dart.dev) version.
- Breaking change: removed the `toJson()` and `toString()` methods from the `Client` class.
- Breaking change: the `version` property is now private.
- Added new values to the `CommentType` enumeration.
- Changed licensing for the [MIT License](https://opensource.org/licenses/MIT).
- Updated the package dependencies.

## Version [2.1.0](https://git.belin.io/cedx/akismet.dart/compare/v2.0.0...v2.1.0)
- Updated the package dependencies.

## Version [2.0.0](https://git.belin.io/cedx/akismet.dart/compare/v1.0.0...v2.0.0)
- Breaking change: changed the signature of all constructors.
- Breaking change: raised the required [Dart](https://dart.dev) version.
- Breaking change: renamed the `Client.serviceUrl` constant to `defaultEndPoint`.
- Added the `Client.endPoint` property.
- Added the `version` constant.
- Updated the package dependencies.

## Version 1.0.0
- Breaking change: changed the `Blog.language` string property for the `languages` list property.
- Breaking change: dropped the [dart:html](https://api.dart.dev/stable/dart-html/dart-html-library.html) client.
- Breaking change: dropped the embedded server and the command line interface.
- Breaking change: merged all the libraries (e.g. `core`, `html` and `io`) into the sole `akismet` one.
- Breaking change: most of the constructors are now using optional named parameters.
- Breaking change: removed the `DEFAULT_SERVICE` constant, `serviceUrl` property and `queryService()` method from the `Client` class.
- Breaking change: removed the `EndPoints` and `HttpHeaders` enumerations.
- Breaking change: removed the `VERSION` constant.
- Breaking change: using lowercase for all constant names.
- Added the `Client.toJson()` method.
- Added the `onRequest` and `onResponse` event streams to the `Client` class.
- The parameters of the `Client` constructor are now optional.
- Added support for the [Travis CI](https://travis-ci.com) continuous integration.
- Changed the build system for [Grinder](https://pub.dev/packages/grinder).
- Changed the documentation system for [Dartdoc](https://dart.dev/tools/dartdoc).
- Changed the licensing for the [Apache License Version 2.0](http://www.apache.org/licenses/LICENSE-2.0).
- Dropped the development dependencies based on [Node.js](https://nodejs.org).
- Removed the info suffix from the Dart version number in the `Client.userAgent` property.
- Updated the package dependencies.

## Version 0.6.1
- Fixed bugs in `async`/`await` implementation.
- Fixed bugs in JSON serialization.

## Version 0.6.0
- Added the `role` property to `Author` class.
- Added the `isTest` property to `Client` class.
- Added the `date` and `postModified` properties to `Comment` class.
- Moved the `Future` API to `async` and `await`.

## Version 0.5.1
- Using [Gulp.js](https://gulpjs.com) as build system.

## Version 0.5.0
- Breaking change: renamed `Server.start()` method to `bind`.
- Added `Server.bindSecure()` method to support SSL protocol.
- Updated the package dependencies.

## Version 0.4.0
- Moved most methods and properties of `Client` child classes to the base abstract class.
- Added `Blog` class to support the latest Akismet APIs.
- Added `Server` events: you can listen to `onClose`, `onError`, `onListening` and `onRequest` streams.
- Added `--silent` option to server CLI.
- Breaking change: renamed `Server.stop()` method to `close`.
- Breaking change: renamed `HTTPHeaders` constants by using `X_` as prefix.
- Breaking change: removed `Client.useSecureRequests` property.

## Version 0.3.2
- Migrated build system and tools to [ShellJS](http://shelljs.org).
- Migrated documentation comments to [YUIDoc](http://yui.github.io/yuidoc).
- Using DocGen.js to generate the API reference.

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
- Added client implementation based on [dart:html](https://api.dart.dev/stable/dart-html/dart-html-library.html).
- Added server implementation used to proxy requests from HTML clients to [Akismet](https://akismet.com) service.
- Breaking change: `Uri` in constructors can no longer be specified as `String`.
- Breaking change: removed `Client.encoding` property.

## Version 0.1.1
- Added `EndPoints` class providing the URLs of the [Akismet](https://akismet.com) service end points.

## Version 0.1.0
- Initial release: client implementation based on [dart:io](https://api.dart.dev/stable/dart-io/dart-io-library.html).
