# Akismet for Dart
![Runtime](https://img.shields.io/badge/dart-%3E%3D1.24-brightgreen.svg) ![Release](https://img.shields.io/pub/v/akismet.svg) ![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg) ![Coverage](https://coveralls.io/repos/github/cedx/akismet.dart/badge.svg) ![Build](https://travis-ci.org/cedx/akismet.dart.svg)

Prevent comment spam using the [Akismet](https://akismet.com) service, in [Dart](https://www.dartlang.org).

## Features
- [Key verification](https://akismet.com/development/api/#verify-key): checks an Akismet API key and gets a value indicating whether it is valid.
- [Comment check](https://akismet.com/development/api/#comment-check): checks a comment and gets a value indicating whether it is spam.
- [Submit spam](https://akismet.com/development/api/#submit-spam): submits a comment that was not marked as spam but should have been.
- [Submit ham](https://akismet.com/development/api/#submit-ham): submits a comment that was incorrectly marked as spam but should not have been.

## Requirements
The latest [Dart SDK](https://www.dartlang.org) and [Pub](https://pub.dartlang.org) versions.
If you plan to play with the sources, you will also need the latest [Grinder](http://google.github.io/grinder.dart) version.

## Installing via [Pub](https://pub.dartlang.org)

### 1. Depend on it
Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  akismet: *
```

### 2. Install it
Install this package and its dependencies from a command prompt:

```shell
$ pub get
```

### 3. Import it
Now in your [Dart](https://www.dartlang.org) code, you can use:

```dart
import 'package:akismet/akismet.dart';
```

## Usage

### Key verification

```dart
try {
  var client = new Client('your API key', 'http://your.blog.url');
  var isValid = await client.verifyKey();
  print(isValid ? 'Your API key is valid.' : 'Your API key is invalid.');
}

catch (error) {
  print('An error occurred: $error');
}
```

### Comment check

```dart
try {
  var comment = new Comment(
    new Author('127.0.0.1', 'Mozilla/5.0'),
    'A comment.'
  );

  var isSpam = await client.checkComment(comment);
  print(isSpam ? 'The comment is marked as spam.' : 'The comment is marked as ham.');
}

catch (error) {
  print('An error occurred: $error');
}
```

### Submit spam/ham

```dart
try {
  await client.submitSpam(comment);
  print('Spam submitted.');

  await client.submitHam(comment);
  print('Ham submitted.');
}

catch (error) {
  print('An error occurred: $error');
}
```

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

## See also
- [API reference](https://cedx.github.io/akismet.dart)
- [Code coverage](https://coveralls.io/github/cedx/akismet.dart)
- [Continuous integration](https://travis-ci.org/cedx/akismet.dart)

## License
[Akismet for Dart](https://github.com/cedx/akismet.dart) is distributed under the Apache License, version 2.0.
