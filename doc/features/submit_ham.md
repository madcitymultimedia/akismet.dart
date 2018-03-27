# Submit ham
This call is intended for the submission of false positives - items that were incorrectly classified as spam by Akismet. It takes identical arguments as [comment check](comment_check.md) and [submit spam](submit_spam.md).

Remember that, as explained in the [submit spam](submit_spam.md) documentation, you should ensure that any values you're passing here match up with the original and corresponding [comment check](comment_check.md) call.

```
Future<void> Client#submitHam(Comment comment)
```

## Parameters

### comment
The user `Comment` to be submitted, incorrectly classified as spam.

!!! tip
    Ideally, it should be the same object as the one passed to the original [comment check](comment_check.md) API call.

## Return value
A `Future` that completes when the given `Comment` has been submitted.

The future completes with a `ClientException` when an error occurs.
The exception `message` usually includes some debug information, provided by the `X-akismet-debug-help` HTTP header, about what exactly was invalid about the call.

## Example

```dart
import 'dart:async';
import 'package:akismet/akismet.dart';

Future<void> main() async {
  try {
    var comment = new Comment(
      new Author('127.0.0.1', 'Mozilla/5.0'),
      content: 'A valid user comment (ham)'
    );
    
    var client = new Client('123YourAPIKey', 'http://www.yourblog.com');
    var isSpam = await client.checkComment(comment); // `true`, but `false` expected.
    
    print('The comment was incorrectly classified as spam');
    await client.submitHam(comment);
  }

  on ClientException catch (err) {
    print('An error occurred: ${err.message}');
  }
}
```
