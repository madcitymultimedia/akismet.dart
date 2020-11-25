# Submit ham
This call is intended for the submission of false positives - items that were incorrectly classified as spam by Akismet.
It takes identical arguments as [comment check](features/comment_check.md) and [submit spam](features/submit_spam.md).

```dart
Future<void> Client.submitHam(Comment comment)
```

Remember that, as explained in the [submit spam](features/submit_spam.md) documentation, you should ensure
that any values you're passing here match up with the original and corresponding [comment check](features/comment_check.md) call.

See the [Akismet API documentation](https://akismet.com/development/api/#submit-ham) for more information.

## Parameters

### Comment **comment**
The user `Comment` to be submitted, incorrectly classified as spam.

?> Ideally, it should be the same object as the one passed to the original [comment check](features/comment_check.md) API call.

## Return value
A `Future` that completes when the given `Comment` has been submitted.

The future completes with a `ClientException` when an error occurs.
The exception `message` usually includes some debug information, provided by the `X-akismet-debug-help` HTTP header, about what exactly was invalid about the call.

## Example

```dart
import "package:akismet/akismet.dart";

Future<void> main() async {
	try {
		final author = Author("127.0.0.1", "Mozilla/5.0");
		final comment = Comment(author, content: "A valid user comment (ham)");
		
		final client = Client("123YourAPIKey", Blog(Uri.https("www.yourblog.com", "/")));
		final result = await client.checkComment(comment);
		// Got `CheckResult.isSpam`, but `CheckResult.isHam` expected.
		
		print("The comment was incorrectly classified as spam.");
		await client.submitHam(comment);
	}

	on ClientException catch (err) {
		print("An error occurred: ${err.message}");
	}
}
```
