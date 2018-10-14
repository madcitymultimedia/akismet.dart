part of '../io.dart';

/// Submits comments to the [Akismet](https://akismet.com) service.
class Client {

  /// Creates a new client.
  Client(this.apiKey, this.blog, {Uri endPoint, this.isTest = false, String userAgent}):
    endPoint = endPoint ?? Uri.https('rest.akismet.com', '/'),
    userAgent = userAgent ?? 'Dart/$_platformVersion | Akismet/$_packageVersion';

  /// The Akismet API key.
  final String apiKey;

  /// The front page or home URL of the instance making requests.
  final Blog blog;

  /// The URL of the API end point.
  final Uri endPoint;

  /// Value indicating whether the client operates in test mode.
  /// You can use it when submitting test queries to Akismet.
  final bool isTest;

  /// The stream of "request" events.
  Stream<RequestEvent> get onRequest => _onRequest.stream;

  /// The stream of "response" events.
  Stream<RequestEvent> get onResponse => _onResponse.stream;

  /// The user agent string to use when making requests.
  /// If possible, the user agent string should always have the following format: `Application Name/Version | Plugin Name/Version`.
  final String userAgent;

  /// The handler of "request" events.
  final StreamController<RequestEvent> _onRequest = StreamController<RequestEvent>.broadcast();

  /// The handler of "response" events.
  final StreamController<RequestEvent> _onResponse = StreamController<RequestEvent>.broadcast();

  /// Checks the specified [comment] against the service database, and returns a value indicating whether it is spam.
  Future<bool> checkComment(Comment comment) async {
    final url = Uri.parse('${endPoint.scheme}://$apiKey.${endPoint.host}/1.1/comment-check');
    return await _fetch(url, comment.toJson()) == 'true';
  }

  /// Submits the specified [comment] that was incorrectly marked as spam but should not have been.
  Future<void> submitHam(Comment comment) {
    final url = Uri.parse('${endPoint.scheme}://$apiKey.${endPoint.host}/1.1/submit-ham');
    return _fetch(url, comment.toJson());
  }

  /// Submits the specified [comment] that was not marked as spam but should have been.
  Future<void> submitSpam(Comment comment) {
    final url = Uri.parse('${endPoint.scheme}://$apiKey.${endPoint.host}/1.1/submit-spam');
    return _fetch(url, comment.toJson());
  }

  /// Checks the API key against the service database, and returns a value indicating whether it is valid.
  Future<bool> verifyKey() async =>
    await _fetch(endPoint.resolve('1.1/verify-key'), {'key': apiKey}) == 'valid';

  /// Queries the service by posting the specified [fields] to a given end point, and returns the response as a string.
  Future<String> _fetch(Uri endPoint, Map<String, dynamic> fields) async {
    final bodyFields = blog.toJson()..addAll(fields);
    if (isTest) bodyFields['is_test'] = '1';

    final httpClient = http.Client();
    final request = http.Request('POST', endPoint)
      ..bodyFields = bodyFields.cast<String, String>()
      ..headers[HttpHeaders.userAgentHeader] = userAgent;

    _onRequest.add(RequestEvent(request));
    final response = await httpClient.post(request.url, body: request.bodyFields, headers: request.headers);
    _onResponse.add(RequestEvent(request, response));
    httpClient.close();

    if ((response.statusCode ~/ 100) != 2) throw http.ClientException('An error occurred while querying the end point', endPoint);
    if (response.headers.containsKey('x-akismet-debug-help')) throw http.ClientException(response.headers['x-akismet-debug-help'], endPoint);
    return response.body;
  }
}

/// The event parameter used for request events.
class RequestEvent {

  /// Creates a new request event.
  RequestEvent(this.request, [this.response]);

  /// The client request.
  final http.Request request;

  /// The server response.
  final http.Response response;
}