import 'dart:io';
import 'package:akismet/akismet.dart';
import 'package:test/test.dart';

/// Tests the features of the [Client] class.
void main() => group('Client', () {
  final _client = new Client(Platform.environment['AKISMET_API_KEY'], 'https://github.com/cedx/akismet.dart')
    ..isTest = true;

  var author = new Author('192.168.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:42.0) Gecko/20100101 Firefox/42.0')
    ..name = 'Akismet'
    ..role = 'administrator'
    ..url = Uri.parse('https://github.com/cedx/akismet.dart');

  final ham = new Comment(author, 'I\'m testing out the Service API.', CommentType.comment)
    ..referrer = Uri.parse('https://pub.dartlang.org/packages/akismet');

  author = new Author('127.0.0.1', 'Spam Bot/6.6.6')..name = 'viagra-test-123';
  final spam = new Comment(author, 'Spam!', CommentType.trackback);

  group('.checkComment()', () {
    test('should return `false` for valid comment (e.g. ham)', () async {
      expect(await _client.checkComment(ham), isFalse);
    });

    test('should return `true` for invalid comment (e.g. spam)', () async {
      expect(await _client.checkComment(spam), isTrue);
    });
  });

  group('.submitHam()', () {
    test('should complete without error', () {
      expect(_client.submitHam(ham), completes);
    });
  });

  group('.submitSpam()', () {
    test('should complete without error', () {
      expect(_client.submitSpam(spam), completes);
    });
  });

  group('.toJson()', () {
    test('should return the right values for an incorrectly configured client', () {
      var client = new Client('0123456789-ABCDEF')
        ..endPoint = Uri.parse('http://localhost')
        ..userAgent = 'FooBar/6.6.6';

      var data = client.toJson();
      expect(data['apiKey'], equals('0123456789-ABCDEF'));
      expect(data['blog'], isNull);
      expect(data['endPoint'], equals('http://localhost'));
      expect(data['isTest'], isFalse);
      expect(data['userAgent'], equals('FooBar/6.6.6'));
    });

    test('should return the right values for a properly configured client', () {
      var data = _client.toJson();
      expect(data['apiKey'], equals(Platform.environment['AKISMET_API_KEY']));
      expect(data['blog'], equals('Blog'));
      expect(data['endPoint'], equals(Client.defaultEndPoint.toString()));
      expect(data['isTest'], isTrue);

      var version = 'Dart/${Platform.version.substring(0, Platform.version.indexOf(' '))}';
      expect(data['userAgent'].substring(0, version.length), equals(version));
    });
  });

  group('.toString()', () {
    var data = _client.toString();

    test('should start with the class name', () {
      expect(data, contains('Client {'));
    });

    test('should contain the instance properties', () {
      expect(data, contains('"apiKey":"'));
      expect(data, contains('"blog":"Blog"'));
      expect(data, contains('"endPoint":"${Client.defaultEndPoint}"'));
      expect(data, contains('"isTest":true'));
      expect(data, contains('"userAgent":"Dart/'));
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
