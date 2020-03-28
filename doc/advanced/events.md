path: blob/master
source: lib/src/client.dart

# Events
The `Client` class, used to query the Akismet service, triggers some events during its life cycle:

- `request` : emitted every time a request is made to the remote service.
- `response` : emitted every time a response is received from the remote service.

These events are exposed as [`Stream`](https://api.dart.dev/stable/dart-async/Stream-class.html), you can listen to them using the `on<EventName>` properties:

```dart
import 'package:akismet/akismet.dart';

void main() {
  final client = Client('123YourAPIKey', Blog(Uri.https('www.yourblog.com', '/')));

  client.onRequest.listen(
    (request) => print('Client request: ${request.url}')
  );

  client.onResponse.listen(
    (response) => print('Server response: ${response.statusCode}')
  );
}
```
