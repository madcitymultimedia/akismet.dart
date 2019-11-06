# Akismet for Dart
![Runtime](https://img.shields.io/badge/dart-%3E%3D2.6-brightgreen.svg) ![Release](https://img.shields.io/pub/v/akismet.svg) ![License](https://img.shields.io/badge/license-MIT-blue.svg) ![Coverage](https://coveralls.io/repos/github/cedx/akismet.dart/badge.svg) ![Build](https://github.com/cedx/akismet.dart/workflows/build/badge.svg)

Prevent comment spam using the [Akismet](https://akismet.com) service, in [Dart](https://dart.dev).

## Documentation
- [User guide](https://dev.belin.io/akismet.dart)
- [API reference](https://dev.belin.io/akismet.dart/api)

## Development
- [Git repository](https://github.com/cedx/akismet.dart)
- [Pub package](https://pub.dev/packages/akismet)
- [Submit an issue](https://github.com/cedx/akismet.dart/issues)

## Features
- [Key verification](https://akismet.com/development/api/#verify-key): checks an Akismet API key and gets a value indicating whether it is valid.
- [Comment check](https://akismet.com/development/api/#comment-check): checks a comment and gets a value indicating whether it is spam.
- [Submit spam](https://akismet.com/development/api/#submit-spam): submits a comment that was not marked as spam but should have been.
- [Submit ham](https://akismet.com/development/api/#submit-ham): submits a comment that was incorrectly marked as spam but should not have been.

## Usage

### Key verification

```dart
try {
  final client = Client('123YourAPIKey', Blog(Uri.https('www.yourblog.com', '/')));
  final isValid = await client.verifyKey();
  print(isValid ? 'The API key is valid' : 'The API key is invalid');
}

on ClientException catch (err) {
  print('An error occurred: ${err.message}');
}
```

### Comment check

```dart
try {
  final comment = Comment(
    Author('127.0.0.1', 'Mozilla/5.0'),
    content: 'A user comment',
    date: DateTime.now()
  );

  final isSpam = await client.checkComment(comment);
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

These events are exposed as [`Stream`](https://api.dart.dev/stable/dart-async/Stream-class.html), you can listen to them using the `on<EventName>` properties:

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
export AKISMET_API_KEY="<123YourAPIKey>"
```

Then, you can run the `test` script from the command prompt:

```shell
pub run test
```

## License
[Akismet for Dart](https://dev.belin.io/akismet.dart) is distributed under the MIT License.
