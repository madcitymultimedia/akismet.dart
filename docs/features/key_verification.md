# Key verification
Key verification authenticates your key before calling the [comment check](features/comment_check.md),
[submit spam](features/submit_spam.md) or [submit ham](features/submit_ham.md) methods.

```dart
Future<bool> Client.verifyKey()
```

This is the first call that you should make to Akismet and is especially useful
if you will have multiple users with their own Akismet subscriptions using your application.

See the [Akismet API documentation](https://akismet.com/development/api/#verify-key) for more information.

## Parameters
None.

## Return value
A `Future` that completes with a `bool` value indicating whether the client's API key is valid.

The future completes with a `ClientException` when an error occurs.
The exception `message` usually includes some debug information, provided by the `X-akismet-debug-help` HTTP header, about what exactly was invalid about the call.

## Example

```dart
import "package:akismet/akismet.dart";

Future<void> main() async {
	try {
		final client = Client("123YourAPIKey", Blog(Uri.https("www.yourblog.com", "/")));
		final isValid = await client.verifyKey();
		print(isValid ? "The API key is valid." : "The API key is invalid.");
	}

	on ClientException catch (err) {
		print("An error occurred: ${err.message}");
	}
}
```

See the [API reference](https://pub.dev/documentation/akismet) for detailed information about the `Client` and `Blog` classes, and their properties and methods.
