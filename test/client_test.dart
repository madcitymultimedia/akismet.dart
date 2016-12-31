import 'package:akismet/akismet.dart';
import 'package:test/test.dart';

/// The client used to query the service database.
//final Client _client = new Client({
//  apiKey: process.env.AKISMET_API_KEY,
//  blog: 'https://github.com/cedx/akismet.dart',
//  isTest: true
//});

/// A comment with content marked as ham.
//final Comment _ham = new Comment({
//  author: new Author({
//    ipAddress: '192.168.0.1',
//    name: 'Akismet',
//    role: 'administrator',
//    url: 'https://github.com/cedx/akismet.dart',
//    userAgent: 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:42.0) Gecko/20100101 Firefox/42.0'
//  }),
//  content: 'I\'m testing out the Service API.',
//  referrer: 'https://pub.dartlang.org/packages/akismet',
//  type: CommentType.COMMENT
//});

/// A comment with content marked as spam.
//final Comment _spam = new Comment({
//  author: new Author({
//    ipAddress: '127.0.0.1',
//    name: 'viagra-test-123',
//    userAgent: 'Spam Bot/6.6.6'
//  }),
//  content: 'Spam!',
//  type: CommentType.TRACKBACK
//});

/// Tests the features of the [Client] class.
void main() => group('Client', () {
  group('.toJson()', () {
    test('should return a map with the same public values', () {
      var data = new Client('anonymous', 'secret').toJson();
      expect(data, isMap);
      expect(data, hasLength(2));
      expect(data['password'], equals('secret'));
      expect(data['username'], equals('anonymous'));
    });
  });
});

/*
group('Client', function() {
  timeout(15000);

  group('constructor', () {
    test('should initialize the existing properties', () {
      var client = new Client({apiKey: '0123456789-ABCDEF', blog: 'https://github.com/cedx/akismet.dart', userAgent: 'FooBar/6.6.6'});
      expect(client.apiKey, '0123456789-ABCDEF');
      expect(client.userAgent, 'FooBar/6.6.6');

      expect(client.blog instanceof Blog);
      expect(client.blog.url, 'https://github.com/cedx/akismet.dart');
    });

    test('should not create new properties', () {
      expect(!('foo' in new Client({foo: 'bar'})));
    });
  });

  group('#checkComment()', () {
    test('should return `false` for valid comment (e.g. ham)' , done => {
      _client.checkComment(_ham).subscribe(res => expect(res, false), done, done);
    });

    test('should return `true` for invalid comment (e.g. spam)' , done => {
      _client.checkComment(_spam).subscribe(res => expect(res, true), done, done);
    });
  });

  group('#submitHam()', () {
    test('should complete without error' , done => {
      _client.submitHam(_ham).subscribe(null, done, done);
    });
  });

  group('#submitSpam()', () {
    test('should complete without error' , done => {
      _client.submitSpam(_spam).subscribe(null, done, done);
    });
  });

  group('#toJson()', () {
    test('should return the right values for an incorrectly configured client' , () {
      var data = new Client({apiKey: '0123456789-ABCDEF', userAgent: 'FooBar/6.6.6'}).toJson();
      expect(data.apiKey, '0123456789-ABCDEF');
      expect(data.blog, null);
      expect(!data.isTest);
      expect(data.userAgent, 'FooBar/6.6.6');
    });

    test('should return the right values for a properly configured client' , () {
      var data = _client.toJson();
      expect(data.apiKey, process.env.AKISMET_API_KEY);
      expect(data.blog, 'Blog');
      expect(data.isTest);

      var version = 'Dart/${process.version}';
      expect(data.userAgent.substr(0, version.length), version);
    });
  });

  group('#verifyKey()', () {
    test('should return `true` for a valid API key' , done => {
      _client.verifyKey().subscribe(res => expect(res, true), done, done);
    });

    test('should return `false` for an invalid API key' , done => {
      var client = new Client({apiKey: '0123456789-ABCDEF', blog: _client.blog, test: _client.isTest});
      client.verifyKey().subscribe(res => expect(res, false), done, done);
    });
  });
});
*/
