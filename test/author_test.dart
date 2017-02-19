import 'package:akismet/akismet.dart';
import 'package:test/test.dart';

/// Tests the features of the [Author] class.
void main() => group('Author', () {
  group('.fromJson()', () {
    test('should return an empty instance with an empty map', () {
      var author = new Author.fromJson(const {});
      expect(author.email, isNull);
      expect(author.ipAddress, isNull);
    });

    test('should return an initialized instance with a non-empty map', () {
      var author = new Author.fromJson(const {
        'comment_author_email': 'cedric@belin.io',
        'comment_author_url': 'https://belin.io',
        'user_ip': '127.0.0.1'
      });

      expect(author.email, equals('cedric@belin.io'));
      expect(author.ipAddress, equals('127.0.0.1'));
      expect(author.url, equals(Uri.parse('https://belin.io')));
    });
  });

  group('.toJson()', () {
    test('should return an empty map with a newly created instance', () {
      expect(new Author().toJson(), allOf(isMap, isEmpty));
    });

    test('should return a non-empty map with a initialized instance', () {
      var author = new Author('127.0.0.1')
        ..email = 'cedric@belin.io'
        ..name = 'Cédric Belin'
        ..url = Uri.parse('https://belin.io');

      var data = author.toJson();
      expect(data, allOf(isMap, hasLength(4)));
      expect(data['comment_author'], equals('Cédric Belin'));
      expect(data['comment_author_email'], equals('cedric@belin.io'));
      expect(data['comment_author_url'], equals('https://belin.io'));
      expect(data['user_ip'], equals('127.0.0.1'));
    });
  });

  group('.toString()', () {
    var author = new Author('127.0.0.1')
      ..email = 'cedric@belin.io'
      ..name = 'Cédric Belin'
      ..url = Uri.parse('https://belin.io');

    var data = author.toString();
    test('should start with the class name', () {
      expect(data, contains('Author {'));
    });

    test('should contain the instance properties', () {
      expect(data, contains('"comment_author":"Cédric Belin"'));
      expect(data, contains('"comment_author_email":"cedric@belin.io"'));
      expect(data, contains('"comment_author_url":"https://belin.io"'));
      expect(data, contains('"user_ip":"127.0.0.1"'));
    });
  });
});
