# Comment check
This is the call you will make the most. It takes a number of arguments and characteristics about the submitted content and then returns a thumbs up or thumbs down. **Performance can drop dramatically if you choose to exclude data points.** The more data you send Akismet about each comment, the greater the accuracy. We recommend erring on the side of including too much data.

```
Future<bool> Client#checkComment(Comment comment)
```

!!! tip "Testing your data"
    It is important to test Akismet with a significant amount of real, live data in order to draw any conclusions on accuracy.
    Akismet works by comparing content to genuine spam activity happening right now (and this is based on more than just the content itself),
    so artificially generating spam comments is not a viable approach.

## Parameters

### comment
The `Comment` providing the user message to be checked.

## Return value
A `Future` that completes with a `bool` value indicating whether the given `Comment` is spam.

The future completes with a `ClientException` when an error occurs.
The exception `message` usually includes some debug information, provided by the `X-akismet-debug-help` HTTP header, about what exactly was invalid about the call.

## Example

```dart
import 'dart:async';
import 'package:akismet/akismet.dart';

Future<void> main() async {
  try {
    final client = Client('123YourAPIKey', 'http://www.yourblog.com');

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
}
```
