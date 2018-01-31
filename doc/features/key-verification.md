path: blob/master
source: lib/src/http/client.dart

# Key verification
Key verification authenticates your key before calling the [comment check](comment-check.md), [submit spam](submit-spam.md), or [submit ham](submit-ham.md) methods. This is the first call that you should make to Akismet and is especially useful if you will have multiple users with their own Akismet subscriptions using your application.

```dart
Future<bool> Client.verifyKey()
```

## Parameters
None.

## Return value
A `Future` that completes with a `bool` value indicating whether the client's API key is valid.

The future completes with a `ClientException` from the [`http`](https://pub.dartlang.org/packages/http) package when an error occurs.
The exception `message` usually includes some debug information, provided by the `X-akismet-debug-help` HTTP header, about what exactly was invalid about the call.

## Example

```dart
import 'dart:async';
import 'package:akismet/akismet.dart';

Future<Null> main() async {
  try {
    var client = new Client('123YourAPIKey', 'http://www.yourblog.com');
    var isValid = await client.verifyKey();
    print(isValid ? 'The API key is valid' : 'The API key is invalid');
  }

  on ClientException catch (err) {
    print('An error occurred: ${err.message}');
  }
}
```
