# Comment check
This is the call you will make the most. It takes a number of arguments and characteristics about the submitted content
and then returns a thumbs up or thumbs down. **Performance can drop dramatically if you choose to exclude data points.**
The more data you send Akismet about each comment, the greater the accuracy. We recommend erring on the side of including too much data.

```dart
Future<CheckResult> Client.checkComment(Comment comment)
```

It is important to [test Akismet](advanced/testing.md) with a significant amount of real, live data in order to draw any conclusions on accuracy.
Akismet works by comparing content to genuine spam activity happening **right now** (and this is based on more than just the content itself),
so artificially generating spam comments is not a viable approach.

See the [Akismet API documentation](https://akismet.com/development/api/#comment-check) for more information.

## Parameters

### Comment **comment**
The `Comment` providing the user message to be checked.

## Return value
A `Future` that completes with a `CheckResult` value indicating whether the given `Comment` is ham, spam or pervasive spam.

?> A comment classified as pervasive spam can be safely discarded.

The future completes with a `ClientException` when an error occurs.
The exception `message` usually includes some debug information, provided by the `X-akismet-debug-help` HTTP header, about what exactly was invalid about the call.

## Example

```dart
import "package:akismet/akismet.dart";

Future<void> main() async {
	try {
		final author = Author("127.0.0.1", "Mozilla/5.0");
		final comment = Comment(author, content: "A user comment", date: DateTime.now());

		final client = Client("123YourAPIKey", Blog(Uri.https("www.yourblog.com", "/")));
		final result = await client.checkComment(comment);
		print(result == CheckResult.isHam ? "The comment is ham." : "The comment is spam.");
	}

	on ClientException catch (err) {
		print("An error occurred: ${err.message}");
	}
}
```

See the [API reference](https://pub.dev/documentation/akismet) of this library for detailed information about the `Author` and `Comment` classes, and their properties.
