# Usage

## Features
There are three different types of calls to Akismet:

1. [Key verification](usage/key_verification.md) will verify whether or not a valid API key is being used. This is especially useful if you will have multiple users with their own Akismet subscriptions using your application.
2. [Comment check](usage/comment_check.md) is used to ask Akismet whether or not a given post, comment, profile, etc. is spam.
3. [Submit spam](usage/submit_spam.md) and [submit ham](usage/submit_ham.md) are follow-ups to let Akismet know when it got something wrong (missed spam and false positives). These are very important, and you shouldn't develop using the Akismet API without a facility to include reporting missed spam and false positives.

See the detailed documentation of each feature for more information.

## Events
The `Client` entry class, used to query the Akismet service, triggers some events during its life cycle:

- `request` : emitted every time a request is made to the remote service.
- `response` : emitted every time a response is received from the remote service.

These events are exposed as [`Stream`](https://api.dart.dev/stable/dart-async/Stream-class.html), you can listen to them using the `on<EventName>` properties:

```dart
client.onRequest.listen(
  (request) => print('Client request: ${request.url}')
);

client.onResponse.listen(
  (response) => print('Server response: ${response.statusCode}')
);
```
