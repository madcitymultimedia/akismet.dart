import 'package:akismet/akismet.dart';
import 'package:test/test.dart';

/// Tests the features of the [Blog] class.
void main() => group('Blog', () {
  group('constructor', () {
    test('should properly initialize the `url` property', () {
      expect(new Blog().url, isNull);

      var url = Uri.parse('https://github.com/cedx/akismet.dart');
      expect(new Blog(url: url).url, same(url));
      expect(new Blog(url: url.toString()).url, equals(url));
    });
  });

  group('.fromJson()', () {
    test('should return an empty instance with an empty map', () {
      var blog = new Blog.fromJson(const {});
      expect(blog.charset, isNull);
      expect(blog.languages, allOf(isList, hasLength(0)));
      expect(blog.url, isNull);
    });

    test('should return an initialized instance with a non-empty map', () {
      var blog = new Blog.fromJson(const {
        'blog': 'https://github.com/cedx/akismet.dart',
        'blog_charset': 'UTF-8',
        'blog_lang': 'en, fr'
      });

      expect(blog.charset, equals('UTF-8'));
      expect(blog.languages, allOf(isList, hasLength(2)));
      expect(blog.languages, orderedEquals(const ['en', 'fr']));
      expect(blog.url, equals(Uri.parse('https://github.com/cedx/akismet.dart')));
    });
  });

  group('.toJson()', () {
    test('should return an empty map with a newly created instance', () {
      expect(new Blog().toJson(), allOf(isMap, hasLength(0)));
    });

    test('should return a non-empty map with a initialized instance', () {
      var data = new Blog(
        charset: 'UTF-8',
        languages: 'en, fr',
        url: 'https://github.com/cedx/akismet.dart'
      ).toJson();

      expect(data, allOf(isMap, hasLength(3)));
      expect(data['blog'], equals('https://github.com/cedx/akismet.dart'));
      expect(data['blog_charset'], equals('UTF-8'));
      expect(data['blog_lang'], equals('en,fr'));
    });
  });
});