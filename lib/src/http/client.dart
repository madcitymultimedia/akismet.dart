part of '../http.dart';

/// Submits comments to the [Akismet](https://akismet.com) service.
class Client {

  /// Creates a new client.
  Client(this.apiKey, this.blog, {Uri endPoint, this.isTest = false, String userAgent}):
    endPoint = endPoint ?? Uri.https('rest.akismet.com', '/1.1/'),
    userAgent = userAgent ?? 'Dart/$platformVersion | Akismet/$packageVersion';

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
  Stream<http.Request> get onRequest => _onRequest.stream;

  /// The stream of "response" events.
  Stream<http.Response> get onResponse => _onResponse.stream;

  /// The user agent string to use when making requests.
  /// If possible, the user agent string should always have the following format: `Application Name/Version | Plugin Name/Version`.
  final String userAgent;

  /// The handler of "request" events.
  final StreamController<http.Request> _onRequest = StreamController<http.Request>.broadcast();

  /// The handler of "response" events.
  final StreamController<http.Response> _onResponse = StreamController<http.Response>.broadcast();

  /// Checks the specified [comment] against the service database, and returns a value indicating whether it is spam.
  Future<CheckResult> checkComment(Comment comment) async {
    final url = Uri.parse('${endPoint.scheme}://$apiKey.${endPoint.host}:${endPoint.port}${endPoint.path}');
    final response = await _fetch(url.resolve('comment-check'), comment.toJson());
    if (response.body != 'true') return CheckResult.isHam;
    return response.headers.containsKey('X-akismet-pro-tip') && response.headers['X-akismet-pro-tip'] == 'discard'
      ? CheckResult.isPervasiveSpam
      : CheckResult.isSpam;
  }

  /// Submits the specified [comment] that was incorrectly marked as spam but should not have been.
  Future<void> submitHam(Comment comment) {
    final url = Uri.parse('${endPoint.scheme}://$apiKey.${endPoint.host}:${endPoint.port}${endPoint.path}');
    return _fetch(url.resolve('submit-ham'), comment.toJson());
  }

  /// Submits the specified [comment] that was not marked as spam but should have been.
  Future<void> submitSpam(Comment comment) {
    final url = Uri.parse('${endPoint.scheme}://$apiKey.${endPoint.host}:${endPoint.port}${endPoint.path}');
    return _fetch(url.resolve('submit-spam'), comment.toJson());
  }

  /// Checks the API key against the service database, and returns a value indicating whether it is valid.
  Future<bool> verifyKey() async =>
    (await _fetch(endPoint.resolve('verify-key'), {'key': apiKey})).body == 'valid';

  /// Queries the service by posting the specified [fields] to a given end point, and returns the response as a string.
  Future<http.Response> _fetch(Uri endPoint, Map<String, dynamic> fields) async {
    final bodyFields = blog.toJson()..addAll(fields);
    if (isTest) bodyFields['is_test'] = '1';

    final httpClient = http.Client();
    final request = http.Request('POST', endPoint)
      ..bodyFields = Map<String, String>.from(bodyFields)
      ..headers[HttpHeaders.userAgentHeader] = userAgent;

    _onRequest.add(request);
    final response = await httpClient.post(request.url, body: request.bodyFields, headers: request.headers);
    _onResponse.add(response);
    httpClient.close();

    if ((response.statusCode ~/ 100) != 2) throw http.ClientException('An error occurred while querying the end point.', endPoint);
    if (response.headers.containsKey('X-akismet-debug-help')) throw http.ClientException(response.headers['X-akismet-debug-help'], endPoint);
    return response;
  }
}

/// Specifies the result of a comment check.
enum CheckResult {

  /// The comment is not a spam (i.e. a ham).
  isHam,

  /// The comment is a spam.
  isSpam,

  /// The comment is a pervasive spam (i.e. it can be safely discarded).
  isPervasiveSpam
}
