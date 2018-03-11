import 'package:akismet/akismet.dart';
import 'package:test/test.dart';

/// Tests the features of the [Author] class.
void main() => group('Author', () {
  group('.fromJson()', () {
    test('should return an empty instance with an empty map', () {
      var author = new Author.fromJson(const {});
      expect(author.email, isEmpty);
      expect(author.ipAddress, isEmpty);
      expect(author.userAgent, isEmpty);
    });

    test('should return an initialized instance with a non-empty map', () {
      var author = new Author.fromJson(const {
        'comment_author_email': 'cedric@belin.io',
        'comment_author_url': 'https://belin.io',
        'user_agent': 'Mozilla/5.0',
        'user_ip': '127.0.0.1'
      });

      expect(author.email, equals('cedric@belin.io'));
      expect(author.ipAddress, equals('127.0.0.1'));
      expect(author.url, equals(new Uri.https('belin.io', '/')));
      expect(author.userAgent, equals('Mozilla/5.0'));
    });
  });

  group('.toJson()', () {
    test('should return only the IP address and user agent with a newly created instance', () {
      var data = new Author('127.0.0.1', 'Doom/6.6.6').toJson();
      expect(data, hasLength(2));
      expect(data['user_agent'], equals('Doom/6.6.6'));
      expect(data['user_ip'], equals('127.0.0.1'));
    });

    test('should return a non-empty map with an initialized instance', () {
      var data = new Author('192.168.0.1', 'Mozilla/5.0', email: 'cedric@belin.io', name: 'Cédric Belin', url: new Uri.https('belin.io', '/')).toJson();
      expect(data, hasLength(5));
      expect(data['comment_author'], equals('Cédric Belin'));
      expect(data['comment_author_email'], equals('cedric@belin.io'));
      expect(data['comment_author_url'], equals('https://belin.io'));
      expect(data['user_agent'], equals('Mozilla/5.0'));
      expect(data['user_ip'], equals('192.168.0.1'));
    });
  });

  group('.toString()', () {
    var data = new Author('127.0.0.1', 'Doom/6.6.6', email: 'cedric@belin.io', name: 'Cédric Belin', url: new Uri.https('belin.io', '/')).toString();

    test('should start with the class name', () {
      expect(data, contains('Author {'));
    });

    test('should contain the instance properties', () {
      expect(data, contains('"comment_author":"Cédric Belin"'));
      expect(data, contains('"comment_author_email":"cedric@belin.io"'));
      expect(data, contains('"comment_author_url":"https://belin.io"'));
      expect(data, contains('"user_agent":"Doom/6.6.6"'));
      expect(data, contains('"user_ip":"127.0.0.1"'));
    });
  });
});
