// ignore_for_file: avoid_print
import 'package:akismet/akismet.dart';

/// Queries the Akismet service.
Future<void> main() async {
  try {
    // Key verification.
    final client = Client('123YourAPIKey', Blog(Uri.https('www.yourblog.com', '/')));
    final isValid = await client.verifyKey();
    print(isValid ? 'The API key is valid' : 'The API key is invalid');

    // Comment check.
    final comment = Comment(
      Author('127.0.0.1', 'Mozilla/5.0'),
      content: 'A user comment',
      type: CommentType.contactForm
    );

    final isSpam = await client.checkComment(comment);
    print(isSpam ? 'The comment is spam' : 'The comment is ham');

    // Submit spam / ham.
    await client.submitSpam(comment);
    print('Spam submitted');

    await client.submitHam(comment);
    print('Ham submitted');
  }

  on Exception catch (err) {
    print('An error occurred: $err');
    if (err is ClientException) print('From: ${err.uri}');
  }
}
