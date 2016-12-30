# Akismet for Dart
![Release](https://img.shields.io/pub/v/akismet.svg) ![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg) ![Coverage](https://coveralls.io/repos/github/cedx/akismet.dart/badge.svg) ![Build](https://travis-ci.org/cedx/akismet.dart.svg)

Prevent comment spam using the [Akismet](https://akismet.com) service, in [Dart](https://www.dartlang.org).

## Features
- [Key verification](https://akismet.com/development/api/#verify-key): checks an Akismet API key and gets a value indicating whether it is valid.
- [Comment check](https://akismet.com/development/api/#comment-check): checks a comment and gets a value indicating whether it is spam.
- [Submit spam](https://akismet.com/development/api/#submit-spam): submits a comment that was not marked as spam but should have been.
- [Submit ham](https://akismet.com/development/api/#submit-ham): submits a comment that was incorrectly marked as spam but should not have been.

## Requirements
The latest [Dart SDK](https://www.dartlang.org) and [Pub](https://pub.dartlang.org) versions.
If you plan to play with the sources, you will also need the latest [Grinder](http://google.github.io/grinder.dart) version.

## Events
The `Client` class triggers some events during its life cycle:

- `request` : emitted every time a request is made to the remote service.
- `response` : emitted every time a response is received from the remote service.

These events are exposed as [`Stream`](https://api.dartlang.org/stable/dart-async/Stream-class.html), you can listen to them using the `on<EventName>` properties:

```dart
client.onRequest.listen(
  (request) => print('Client request: ${request.url}')
);

client.onResponse.listen(
  (response) => print('Server response: ${response.statusCode}')
);
```

## Unit tests
In order to run the tests, you must set the `AKISMET_API_KEY` environment variable to the value of your Akismet API key:

```shell
$ export AKISMET_API_KEY="<YourAPIKey>"
```

Then, you can run the `test` script from the command prompt:

```shell
$ pub run test
```

## See Also
- [API reference](https://cedx.github.io/akismet.dart)
- [Code coverage](https://coveralls.io/github/cedx/akismet.dart)
- [Continuous integration](https://travis-ci.org/cedx/akismet.dart)

## License
[Akismet for Dart](https://github.com/cedx/akismet.dart) is distributed under the Apache License, version 2.0.
