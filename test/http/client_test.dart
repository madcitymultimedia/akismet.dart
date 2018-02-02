@TestOn('vm')

import 'dart:io';
import 'package:akismet/akismet.dart';
import 'package:test/test.dart';

/// Tests the features of the [Client] class.
void main() => group('Client', () {
  final _client = new Client(
    const String.fromEnvironment('akismet_api_key') ?? Platform.environment['AKISMET_API_KEY'],
    'https://cedx.github.io/akismet.dart',
    isTest: true
  );

  final ham = new Comment(
    new Author('192.168.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:42.0) Gecko/20100101 Firefox/42.0',
      name: 'Akismet',
      role: 'administrator',
      url: Uri.parse('https://cedx.github.io/akismet.dart')
    ),
    content: 'I\'m testing out the Service API.',
    referrer: Uri.parse('https://pub.dartlang.org/packages/akismet'),
    type: CommentType.comment
  );

  final spam = new Comment(
    new Author('127.0.0.1', 'Spam Bot/6.6.6',
      email: 'akismet-guaranteed-spam@example.com',
      name: 'viagra-test-123'
    ),
    content: 'Spam!',
    type: CommentType.trackback
  );

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

  group('.verifyKey()', () {
    test('should return `true` for a valid API key', () async {
      expect(await _client.verifyKey(), isTrue);
    });

    test('should return `false` for an invalid API key', () async {
      var client = new Client('0123456789-ABCDEF', _client.blog, isTest: _client.isTest);
      expect(await client.verifyKey(), isFalse);
    });
  });
}, testOn: 'vm');
