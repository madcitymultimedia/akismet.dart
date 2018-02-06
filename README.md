# Akismet for Dart
![Runtime](https://img.shields.io/badge/dart-%3E%3D2.0-brightgreen.svg) ![Release](https://img.shields.io/pub/v/akismet.svg) ![License](https://img.shields.io/badge/license-MIT-blue.svg) ![Coverage](https://coveralls.io/repos/github/cedx/akismet.dart/badge.svg) ![Build](https://travis-ci.org/cedx/akismet.dart.svg)

Prevent comment spam using the [Akismet](https://akismet.com) service, in [Dart](https://www.dartlang.org).

> For detailed instructions, see the [user guide](https://cedx.github.io/akismet.dart).

## Features
- [Key verification](https://akismet.com/development/api/#verify-key): checks an Akismet API key and gets a value indicating whether it is valid.
- [Comment check](https://akismet.com/development/api/#comment-check): checks a comment and gets a value indicating whether it is spam.
- [Submit spam](https://akismet.com/development/api/#submit-spam): submits a comment that was not marked as spam but should have been.
- [Submit ham](https://akismet.com/development/api/#submit-ham): submits a comment that was incorrectly marked as spam but should not have been.

## Requirements
You need the latest [Dart SDK](https://www.dartlang.org/tools/sdk) and [Pub](https://www.dartlang.org/tools/pub) versions to use **Akismet for Dart**.

> If you plan to play with the sources, you will also need the latest [Grinder](http://google.github.io/grinder.dart) and [Material for MkDocs](https://squidfunk.github.io/mkdocs-material) versions.

## Installing with Pub package manager

### 1. Depend on it
Add this to your project's `pubspec.yaml` file:

```yaml
dependencies:
  akismet: *
```

### 2. Install it
Install this package and its dependencies from a command prompt:

```shell
pub get
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
  var client = new Client('123YourAPIKey', 'http://www.yourblog.com');
  var isValid = await client.verifyKey();
  print(isValid ? 'The API key is valid' : 'The API key is invalid');
}

on ClientException catch (err) {
  print('An error occurred: ${err.message}');
}
```

### Comment check

```dart
try {
  var comment = new Comment(
    new Author('127.0.0.1', 'Mozilla/5.0'),
    content: 'A user comment',
    date: new DateTime.now()
  );

  var isSpam = await client.checkComment(comment);
  print(isSpam ? 'The comment is spam' : 'The comment is ham');
}

on ClientException catch (err) {
  print('An error occurred: ${err.message}');
}
```

### Submit spam / ham

```dart
try {
  await client.submitSpam(comment);
  print('Spam submitted');

  await client.submitHam(comment);
  print('Ham submitted');
}

on ClientException catch (err) {
  print('An error occurred: ${err.message}');
}
```

## Events
The `Client` class triggers some events during its life cycle:

- `request` : emitted every time a request is made to the remote service.
- `response` : emitted every time a response is received from the remote service.

These events are exposed as [`Stream<RequestEvent>`](https://api.dartlang.org/stable/dart-async/Stream-class.html), you can listen to them using the `on<EventName>` properties:

```dart
client.onRequest.listen(
  (event) => print('Client request: ${event.request.url}')
);

client.onResponse.listen(
  (event) => print('Server response: ${event.response.statusCode}')
);
```

## Unit tests
In order to run the tests, you must set the `AKISMET_API_KEY` environment variable to the value of your Akismet API key:

```shell
export AKISMET_API_KEY="<123YourAPIKey>"
```

Then, you can run the `test` script from the command prompt:

```shell
pub run test
```

## See also
- [API reference](https://cedx.github.io/akismet.dart/api)
- [Pub package](https://pub.dartlang.org/packages/akismet)
- [Continuous integration](https://travis-ci.org/cedx/akismet.dart)
- [Code coverage](https://coveralls.io/github/cedx/akismet.dart)

### Other implementations
- Node.js: [Akismet for JS](https://cedx.github.io/akismet.js)
- PHP: [Akismet for PHP](https://cedx.github.io/akismet.php)
- Yii Framework: [Akismet for Yii](https://cedx.github.io/yii2-akismet)

## License
[Akismet for Dart](https://cedx.github.io/akismet.dart) is distributed under the MIT License.
