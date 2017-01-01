import 'dart:io';
import 'package:akismet/akismet.dart';
import 'package:test/test.dart';

/// Tests the features of the [Client] class.
void main() => group('Client', () {
  final _client = new Client(Platform.environment['AKISMET_API_KEY'], 'https://github.com/cedx/akismet.dart')
    ..isTest = true;

  final _ham = new Comment(
    author: new Author(
      ipAddress: '192.168.0.1',
      name: 'Akismet',
      role: 'administrator',
      url: 'https://github.com/cedx/akismet.dart',
      userAgent: 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:42.0) Gecko/20100101 Firefox/42.0'
    ),
    content: 'I\'m testing out the Service API.',
    referrer: 'https://pub.dartlang.org/packages/akismet',
    type: CommentType.comment
  );

  final _spam = new Comment(
    author: new Author(
      ipAddress: '127.0.0.1',
      name: 'viagra-test-123',
      userAgent: 'Spam Bot/6.6.6'
    ),
    content: 'Spam!',
    type: CommentType.trackback
  );

  group('constructor', () {
    test('should properly initialize the `blog` property', () {
      expect(new Client().blog, isNull);

      var blog = new Blog(url: 'https://github.com/cedx/akismet.dart');
      expect(new Client('', blog).blog, same(blog));
      expect(new Client('', blog.url.toString()).blog.url, equals(blog.url));
    });
  });

  group('.checkComment()', () {
    test('should return `false` for valid comment (e.g. ham)', () async {
      expect(await _client.checkComment(_ham), isFalse);
    });

    test('should return `true` for invalid comment (e.g. spam)', () async {
      expect(await _client.checkComment(_spam), isTrue);
    });
  });

  group('.submitHam()', () {
    test('should complete without error', () {
      expect(_client.submitHam(_ham), completes);
    });
  });

  group('.submitSpam()', () {
    test('should complete without error', () {
      expect(_client.submitSpam(_spam), completes);
    });
  });

  group('.toJson()', () {
    test('should return the right values for an incorrectly configured client', () {
      var data = (new Client('0123456789-ABCDEF')..userAgent = 'FooBar/6.6.6').toJson();
      expect(data['apiKey'], equals('0123456789-ABCDEF'));
      expect(data['blog'], isNull);
      expect(data['isTest'], isFalse);
      expect(data['userAgent'], equals('FooBar/6.6.6'));
    });

    test('should return the right values for a properly configured client', () {
      var data = _client.toJson();
      expect(data['apiKey'], equals(Platform.environment['AKISMET_API_KEY']));
      expect(data['blog'], equals('Blog'));
      expect(data['isTest'], isTrue);

      var version = 'Dart/${Platform.version.substring(0, 5)}';
      expect(data['userAgent'].substring(0, version.length), equals(version));
    });
  });

  group('.verifyKey()', () {
    test('should return `true` for a valid API key', () async {
      expect(await _client.verifyKey(), isTrue);
    });

    test('should return `false` for an invalid API key', () async {
      var client = new Client('0123456789-ABCDEF', _client.blog)..isTest = _client.isTest;
      expect(await client.verifyKey(), isFalse);
    });
  });
});
