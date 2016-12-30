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

    var dartVersion = Platform.version.split('.').take(3).join('.');
    userAgent = 'Dart/${dartVersion} | Akismet/${VERSION}';
  }

  /// The Akismet API key.
  String apiKey;

  /// The front page or home URL of the instance making requests.
  Blog blog;

  /// Value indicating whether the client operates in test mode.
  /// You can use it when submitting test queries to Akismet.
  bool test = false;

  /// The user agent string to use when making requests.
  /// If possible, the user agent string should always have the following format: `Application Name/Version | Plugin Name/Version`.
  String userAgent;

  /// The handler of "request" events.
  StreamController _onRequest = new StreamController<HttpRequest>.broadcast();

  /// The handler of "response" events.
  StreamController _onResponse = new StreamController<HttpResponse>.broadcast();

  /// The stream of "request" events.
  Stream<HttpRequest> get onRequest => _onRequest.stream;

  /// The stream of "response" events.
  Stream<HttpResponse> get onResponse => _onResponse.stream;

  /**
   * Checks the specified [comment] against the service database, and returns a value indicating whether it is spam.
   * @param {Comment} comment The comment to be checked.
   * @return {Observable<boolean>} A boolean value indicating whether it is spam.
   */
  Future<bool> checkComment(Comment comment) async {
    assert(comment != null);

    var serviceURL = url.parse(Client.SERVICE_URL);
    var endPoint = '${serviceURL.protocol}//${apiKey}.${serviceURL.host}/1.1/comment-check';
    return _fetch(endPoint, comment.toJSON()).map(res => res == 'true');
  }

  /**
   * Submits the specified [comment] that was incorrectly marked as spam but should not have been.
   * @param {Comment} comment The comment to be submitted.
   * @return {Observable} Completes once the comment has been submitted.
   */
  Future submitHam(Comment comment) async {
    assert(comment != null);

    var serviceURL = url.parse(Client.SERVICE_URL);
    var endPoint = '${serviceURL.protocol}//${apiKey}.${serviceURL.host}/1.1/submit-ham';
    return _fetch(endPoint, comment.toJSON());
  }

  /**
   * Submits the specified [comment] that was not marked as spam but should have been.
   * @param {Comment} comment The comment to be submitted.
   * @return {Observable} Completes once the comment has been submitted.
   */
  Future submitSpam(Comment comment) async {
    assert(comment != null);

    var serviceURL = url.parse(Client.SERVICE_URL);
    var endPoint = '${serviceURL.protocol}//${apiKey}.${serviceURL.host}/1.1/submit-spam';
    return _fetch(endPoint, comment.toJSON());
  }

  /**
   * Checks the API key against the service database, and returns a value indicating whether it is valid.
   * @return {Observable<boolean>} A boolean value indicating whether it is a valid API key.
   */
  Future<bool> verifyKey() {
    var endPoint = '${Client.SERVICE_URL}/1.1/verify-key';
    return _fetch(endPoint, {key: apiKey}).map(res => res == 'valid');
  }

  /**
   * Queries the service by posting the specified fields to a given end point, and returns the response as a string.
   * @param {string} endPoint The URL of the end point to query.
   * @param {object} params The fields describing the query body.
   * @return {Observable<string>} The response as string.
   * @throws {Error} The API key or blog URL is empty.
   * @emits {superagent.Request} The "request" event.
   * @emits {superagent.Response} The "response" event.
   */
  Future<String> _fetch(endPoint, params) async {
    /*
    if (!apiKey.length || !blog) return Observable.throw(new Error('The API key or the blog URL is empty.'));

    var bodyParams = Object.assign(blog.toJSON(), params);
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

  /// Converts this object to a map in JSON format.
  Map<String, String> toJson() {
    return {
      apiKey: apiKey,
      blog: blog ? blog.constructor.name : null,
      test: test,
      userAgent: userAgent
    };
  }

  /// Returns a string representation of this object.
  @override String toString() => '${runtimeType} ${JSON.encode(this)}';
}
