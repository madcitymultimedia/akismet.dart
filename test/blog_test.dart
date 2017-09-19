import 'package:akismet/akismet.dart';
import 'package:test/test.dart';

/// Tests the features of the [Blog] class.
void main() => group('Blog', () {
  group('.fromJson()', () {
    test('should return an empty instance with an empty map', () {
      var blog = new Blog.fromJson(const {});
      expect(blog.charset, isEmpty);
      expect(blog.languages, allOf(isList, isEmpty));
      expect(blog.url, isNull);
    });

    test('should return an initialized instance with a non-empty map', () {
      var blog = new Blog.fromJson(const {
        'blog': 'https://github.com/cedx/akismet.dart',
        'blog_charset': 'UTF-8',
        'blog_lang': 'en, fr'
      });

      expect(blog.charset, equals('UTF-8'));
      expect(blog.languages, orderedEquals(const ['en', 'fr']));
      expect(blog.url, equals(Uri.parse('https://github.com/cedx/akismet.dart')));
    });
  });

  group('.toJson()', () {
    test('should return only the blog URL with a newly created instance', () {
      var data = new Blog('https://github.com/cedx/akismet.dart').toJson();
      expect(data, hasLength(1));
      expect(data['blog'], equals('https://github.com/cedx/akismet.dart'));
    });

    test('should return a non-empty map with an initialized instance', () {
      var data = new Blog('https://github.com/cedx/akismet.dart', charset: 'UTF-8', languages: ['en', 'fr']).toJson();
      expect(data, hasLength(3));
      expect(data['blog'], equals('https://github.com/cedx/akismet.dart'));
      expect(data['blog_charset'], equals('UTF-8'));
      expect(data['blog_lang'], equals('en,fr'));
    });
  });

  group('.toString()', () {
    var data = new Blog('https://github.com/cedx/akismet.dart', charset: 'UTF-8', languages: ['en', 'fr']).toString();

    test('should start with the class name', () {
      expect(data, contains('Blog {'));
    });

    test('should contain the instance properties', () {
      expect(data, contains('"blog":"https://github.com/cedx/akismet.dart"'));
      expect(data, contains('"blog_charset":"UTF-8"'));
      expect(data, contains('"blog_lang":"en,fr"'));
    });
  });
});
