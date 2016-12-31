part of akismet;

/// Submits comments to the [Akismet](https://akismet.com) service.
class Client {

  /// The HTTP header containing the Akismet error messages.
  static const String debugHeader = 'x-akismet-debug-help';

  /// The URL of the remote service.
  static final Uri serviceUrl = Uri.parse('https://rest.akismet.com');

  /// Creates a new client.
  Client(this.apiKey, blog) {
    assert(apiKey != null);
    assert(blog != null);

    blog = blog is Blog ? blog : new Blog(blog);
    userAgent = 'Dart/$_dartVersion | Akismet/$_packageVersion';
  }

  /// The Akismet API key.
  String apiKey;

  /// The front page or home URL of the instance making requests.
  Blog blog;

  /// Value indicating whether the client operates in test mode.
  /// You can use it when submitting test queries to Akismet.
  bool isTest = false;

  /// The stream of "request" events.
  Stream<http.Request> get onRequest => _onRequest.stream;

  /// The stream of "response" events.
  Stream<http.Response> get onResponse => _onResponse.stream;

  /// The user agent string to use when making requests.
  /// If possible, the user agent string should always have the following format: `Application Name/Version | Plugin Name/Version`.
  String userAgent;

  /// The handler of "request" events.
  final StreamController<http.Request> _onRequest = new StreamController<http.Request>.broadcast();

  /// The handler of "response" events.
  final StreamController<http.Response> _onResponse = new StreamController<http.Response>.broadcast();

  /// Checks the specified [comment] against the service database, and returns a value indicating whether it is spam.
  Future<bool> checkComment(Comment comment) async {
    assert(comment != null);
    var endPoint = '${serviceUrl.scheme}://$apiKey.${serviceUrl.host}/1.1/comment-check';
    return await _fetch(endPoint, comment.toJson()) == 'true';
  }

  /// Submits the specified [comment] that was incorrectly marked as spam but should not have been.
  Future submitHam(Comment comment) async {
    assert(comment != null);
    var endPoint = '${serviceUrl.scheme}://$apiKey.${serviceUrl.host}/1.1/submit-ham';
    return await _fetch(endPoint, comment.toJson());
  }

  /// Submits the specified [comment] that was not marked as spam but should have been.
  Future submitSpam(Comment comment) async {
    assert(comment != null);
    var endPoint = '${serviceUrl.scheme}://$apiKey.${serviceUrl.host}/1.1/submit-spam';
    return await _fetch(endPoint, comment.toJson());
  }

  /// Checks the API key against the service database, and returns a value indicating whether it is valid.
  Future<bool> verifyKey() async {
    var endPoint = '$serviceUrl/1.1/verify-key';
    return await _fetch(endPoint, {'key': apiKey}) == 'valid';
  }

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => {
    'apiKey': apiKey,
    'blog': blog != null ? blog.runtimeType.toString() : null,
    'test': isTest,
    'userAgent': userAgent
  };

  /// Returns a string representation of this object.
  @override
  String toString() => '$runtimeType ${JSON.encode(this)}';

  /// Queries the service by posting the specified fields to a given end point, and returns the response as a string.
  Future<String> _fetch(endPoint, Map<String, String> params) async {
    /*
    if (!apiKey.length || !blog) return Observable.throw(new Error('The API key or the blog URL is empty.'));

    var bodyParams = Object.assign(blog.toJson(), params);
    if (test) bodyParams.is_test = '1';

    return new Observable(observer => {
      var req = superagent.post(endPoint)
        .type('form')
        .set('User-Agent', userAgent)
        .send(bodyParams);

      _onRequest.next(req);
      req.end((err, res) => {
        if (err) observer.error(err);
        else if (Client.DEBUG_HEADER in res.header) observer.error(new Error(res.header[Client.DEBUG_HEADER]));
        else {
          _onResponse.next(res);
          observer.next(res.text);
          observer.complete();
        }
      });
    });
    */

    return null;
  }
}
