part of akismet;

/// Submits comments to the [Akismet](https://akismet.com) service.
class Client {

  /// The HTTP header containing the Akismet error messages.
  static const String debugHeader = 'x-akismet-debug-help';

  /// The URL of the default API end point.
  static final Uri defaultEndPoint = Uri.parse('https://rest.akismet.com');

  /// Creates a new client.
  Client(this.apiKey, blog, {Uri endPoint, this.isTest = false, String userAgent}):
    blog = blog is Blog ? blog : new Blog(blog),
    endPoint = endPoint != null ? endPoint : defaultEndPoint,
    userAgent = userAgent != null ? userAgent : 'Dart/${Platform.version.split(' ').first} | Akismet/$_version';

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
  final StreamController<http.Request> _onRequest = new StreamController<http.Request>.broadcast();

  /// The handler of "response" events.
  final StreamController<http.Response> _onResponse = new StreamController<http.Response>.broadcast();

  /// Checks the specified [comment] against the service database, and returns a value indicating whether it is spam.
  Future<bool> checkComment(Comment comment) async {
    var url = Uri.parse('${endPoint.scheme}://$apiKey.${endPoint.host}/1.1/comment-check');
    return await _fetch(url, comment.toJson()) == 'true';
  }

  /// Submits the specified [comment] that was incorrectly marked as spam but should not have been.
  Future submitHam(Comment comment) async {
    var url = Uri.parse('${endPoint.scheme}://$apiKey.${endPoint.host}/1.1/submit-ham');
    return _fetch(url, comment.toJson());
  }

  /// Submits the specified [comment] that was not marked as spam but should have been.
  Future submitSpam(Comment comment) async {
    var url = Uri.parse('${endPoint.scheme}://$apiKey.${endPoint.host}/1.1/submit-spam');
    return _fetch(url, comment.toJson());
  }

  /// Checks the API key against the service database, and returns a value indicating whether it is valid.
  Future<bool> verifyKey() async =>
    await _fetch(Uri.parse('$endPoint/1.1/verify-key'), {'key': apiKey}) == 'valid';

  /// Queries the service by posting the specified [fields] to a given end point, and returns the response as a string.
  Future<String> _fetch(Uri endPoint, Map<String, String> fields) async {
    var bodyFields = blog.toJson()..addAll(fields);
    if (isTest) bodyFields['is_test'] = '1';

    var request = new http.Request('POST', endPoint)
      ..bodyFields = bodyFields
      ..headers[HttpHeaders.USER_AGENT] = userAgent;

    _onRequest.add(request);
    var response = await http.post(request.url, body: request.bodyFields, headers: request.headers);
    _onResponse.add(response);

    if (response.headers.containsKey(debugHeader)) throw new http.ClientException(response.headers[debugHeader]);
    return response.body;
  }
}
