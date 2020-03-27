import 'package:akismet/akismet.dart';
import 'package:test/test.dart';

/// Tests the features of the [Blog] class.
void main() => group('Blog', () {
  group('.fromJson()', () {
    test('should return an empty instance with an empty map', () {
      final blog = Blog.fromJson({});
      expect(blog.charset, isNull);
      expect(blog.languages, isEmpty);
      expect(blog.url, isNull);
    });

    test('should return an initialized instance with a non-empty map', () {
      final blog = Blog.fromJson({
        'blog': 'https://dev.belin.io/akismet.dart',
        'blog_charset': 'UTF-8',
        'blog_lang': 'en, fr'
      });

      expect(blog.charset, equals('UTF-8'));
      expect(blog.languages, orderedEquals(<String>['en', 'fr']));
      expect(blog.url, equals(Uri.https('dev.belin.io', '/akismet.dart')));
    });
  });

  group('.toJson()', () {
    test('should return only the blog URL with a newly created instance', () {
      final data = Blog(Uri.https('dev.belin.io', '/akismet.dart')).toJson();
      expect(data, hasLength(1));
      expect(data['blog'], equals('https://dev.belin.io/akismet.dart'));
    });

    test('should return a non-empty map with an initialized instance', () {
      final data = Blog(Uri.https('dev.belin.io', '/akismet.dart'), charset: 'UTF-8', languages: ['en', 'fr']).toJson();
      expect(data, hasLength(3));
      expect(data['blog'], equals('https://dev.belin.io/akismet.dart'));
      expect(data['blog_charset'], equals('UTF-8'));
      expect(data['blog_lang'], equals('en,fr'));
    });
  });
});
