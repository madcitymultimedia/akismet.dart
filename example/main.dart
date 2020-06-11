// ignore_for_file: avoid_print
import "package:akismet/akismet.dart";

/// Queries the Akismet service.
Future<void> main() async {
	try {
		final blog = Blog(Uri.https("www.yourblog.com", "/"), charset: "UTF-8", languages: ["fr"]);
		final client = Client("123YourAPIKey", blog);

		// Key verification.
		final isValid = await client.verifyKey();
		print(isValid ? "The API key is valid." : "The API key is invalid.");

		// Comment check.
		final author = Author(
			"192.168.123.456",
			"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36 Edg/83.0.478.45",
			email: "john.doe@domain.com",
			name: "John Doe",
			role: "guest"
		);

		final comment = Comment(
			author,
			content: "The user comment",
			date: DateTime.now(),
			type: CommentType.contactForm
		);

		final result = await client.checkComment(comment);
		print(result == CheckResult.isHam ? "The comment is ham." : "The comment is spam.");

		// Submit spam / ham.
		await client.submitSpam(comment);
		print("Spam submitted.");

		await client.submitHam(comment);
		print("Ham submitted.");
	}

	on Exception catch (err) {
		print("An error occurred: $err");
		if (err is ClientException) print("From: ${err.uri}");
	}
}
