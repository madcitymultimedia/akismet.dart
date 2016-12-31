import 'package:akismet/akismet.dart';
import 'package:test/test.dart';

/// Tests the features of the [Author] class.
void main() => group('Author', () {
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
group('Author', () {

  group('constructor', () {
    test('should initialize the existing properties', () {
      var author = new Author({email: 'cedric@belin.io', ipAddress: '192.168.0.1', name: 'Cédric Belin'});
      expect(author.email, 'cedric@belin.io');
      expect(author.ipAddress, '192.168.0.1');
      expect(author.name, 'Cédric Belin');
    });

    test('should not create new properties', () {
      expect(!('foo' in new Author({foo: 'bar'})));
    });
  });

  group('.fromJson()', () {
    test('should return a null reference with a non-object JSON string', () {
      expect(Author.fromJson('foo'), null);
    });

    test('should return an empty instance with an empty JSON object', () {
      var author = Author.fromJson({});
      expect(author.email.length, 0);
      expect(author.url.length, 0);
    });

    test('should return an initialized instance with a non-empty JSON object', () {
      var author = Author.fromJson({
        comment_author_email: 'cedric@belin.io',
        comment_author_url: 'https://belin.io'
      });

      expect(author.email, 'cedric@belin.io');
      expect(author.url, 'https://belin.io');
    });
  });

  group('#toJson()', () {
    test('should return an empty JSON object with a newly created instance', () {
      expect(Object.keys(new Author().toJson()).length, 0);
    });

    test('should return a non-empty JSON object with a initialized instance', () {
      var data = new Author({
        email: 'cedric@belin.io',
        ipAddress: '127.0.0.1',
        name: 'Cédric Belin',
        url: 'https://belin.io'
      }).toJson();

      expect(data.comment_author, 'Cédric Belin');
      expect(data.comment_author_email, 'cedric@belin.io');
      expect(data.comment_author_url, 'https://belin.io');
      expect(data.user_ip, '127.0.0.1');
    });
  });
});
*/
