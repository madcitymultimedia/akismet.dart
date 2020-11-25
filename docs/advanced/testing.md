# Testing
When you will integrate this library with your own application, you will of course need to test it. Often we see developers get ahead of themselves, making a few trivial API calls with minimal values and drawing the wrong conclusions about Akismet's accuracy.

## Simulate a positive (spam) result
Make a [comment check](features/comment_check.md) API call with the `Author.name` set to `"viagra-test-123"` or `Author.email` set to <code>&quot;akismet-guaranteed-spam&commat;example.com&quot;</code>. Populate all other required fields with typical values.

The Akismet API will always return a `CheckResult.isSpam` response to a valid request with one of those values. If you receive anything else, something is wrong in your client, data, or communications.

```dart
import "package:akismet/akismet.dart";

Future<void> main() async {
	final author = Author("127.0.0.1", "Mozilla/5.0", name: "viagra-test-123");
	final comment = Comment(author, content: "A user comment");

	final client = Client("123YourAPIKey", Blog(Uri.https("www.yourblog.com", "/")));
	final result = await client.checkComment(comment);
	print("It should be `CheckResult.isSpam`: $result");
}
```

## Simulate a negative (not spam) result
Make a [comment check](features/comment_check.md) API call with the `Author.role` set to `"administrator"` and all other required fields populated with typical values.

The Akismet API will always return a `CheckResult.isHam` response. Any other response indicates a data or communication problem.

```dart
import "package:akismet/akismet.dart";

Future<void> main() async {
	final author = Author("127.0.0.1", "Mozilla/5.0", role: "administrator");
	final comment = Comment(author, content: "A user comment");

	final client = Client("123YourAPIKey", Blog(Uri.https("www.yourblog.com", "/")));
	final result = await client.checkComment(comment);
	print("It should be `CheckResult.isHam`: $result");
}
```

## Automated testing
Enable the `Client.isTest` option in your tests.

That will tell Akismet not to change its behaviour based on those API calls: they will have no training effect. That means your tests will be somewhat repeatable, in the sense that one test won't influence subsequent calls.

```dart
import "package:akismet/akismet.dart";

Future<void> main() async {
	final author = Author("127.0.0.1", "Mozilla/5.0");
	final comment = Comment(author, content: "A user comment");

	final blog = Blog(Uri.https("www.yourblog.com", "/"));
	final client = Client("123YourAPIKey", blog, isTest: true);

	print("It should not influence subsequent calls.");
	await client.checkComment(comment);
}
```
