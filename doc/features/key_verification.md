# Key verification
Key verification authenticates your key before calling the [comment check](comment_check.md), [submit spam](submit_spam.md), 
or [submit ham](submit_ham.md) methods. This is the first call that you should make to Akismet and is especially useful
if you will have multiple users with their own Akismet subscriptions using your application.

```
Future<bool> Client#verifyKey()
```

## Parameters
None.

## Return value
A `Future` that completes with a `bool` value indicating whether the client's API key is valid.

The future completes with a `ClientException` when an error occurs.
The exception `message` usually includes some debug information, provided by the `X-akismet-debug-help` HTTP header, about what exactly was invalid about the call.

## Example

```dart
import 'dart:async';
import 'package:akismet/akismet.dart';

Future<void> main() async {
  try {
    final client = Client('123YourAPIKey', Blog(Uri.https('www.yourblog.com', '/')));
    final isValid = await client.verifyKey();
    print(isValid ? 'The API key is valid' : 'The API key is invalid');
  }

  on ClientException catch (err) {
    print('An error occurred: ${err.message}');
  }
}
```
