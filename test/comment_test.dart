import 'package:akismet/akismet.dart';
import 'package:test/test.dart';

/// Tests the features of the [Comment] class.
void main() => group('Comment', () {
  group('.fromJson()', () {
    test('should return an empty instance with an empty map', () {
      var comment = new Comment.fromJson(const {});
      expect(comment.author, isNull);
      expect(comment.content, isEmpty);
      expect(comment.date, isNull);
      expect(comment.referrer, isNull);
      expect(comment.type, isEmpty);
    });

    test('should return an initialized instance with a non-empty map', () {
      var comment = new Comment.fromJson(const {
        'comment_author': 'Cédric Belin',
        'comment_content': 'A user comment.',
        'comment_date_gmt': '2000-01-01T00:00:00.000Z',
        'comment_type': 'trackback',
        'referrer': 'https://belin.io'
      });

      expect(comment.author, new isInstanceOf<Author>());
      expect(comment.author.name, equals('Cédric Belin'));
      expect(comment.content, equals('A user comment.'));
      expect(comment.date, new isInstanceOf<DateTime>());
      expect(comment.referrer, equals(Uri.parse('https://belin.io')));
      expect(comment.type, equals(CommentType.trackback));
    });
  });

  group('.toJson()', () {
    test('should return an empty map with a newly created instance', () {
      expect(new Comment().toJson(), allOf(isMap, isEmpty));
    });

    test('should return a non-empty map with a initialized instance', () {
      var author = new Author()..name = 'Cédric Belin';
      var comment = new Comment(author, 'A user comment.', CommentType.pingback)
        ..date = DateTime.parse('2000-01-01T00:00:00.000Z')
        ..referrer = Uri.parse('https://belin.io');

      var data = comment.toJson();
      expect(data, allOf(isMap, hasLength(5)));
      expect(data['comment_author'], 'Cédric Belin');
      expect(data['comment_content'], 'A user comment.');
      expect(data['comment_date_gmt'], '2000-01-01T00:00:00.000Z');
      expect(data['comment_type'], 'pingback');
      expect(data['referrer'], 'https://belin.io');
    });
  });

  group('.toString()', () {
    var author = new Author()..name = 'Cédric Belin';
    var comment = new Comment(author, 'A user comment.', CommentType.pingback)
      ..date = DateTime.parse('2000-01-01T00:00:00.000Z')
      ..referrer = Uri.parse('https://belin.io');

    var data = comment.toString();
    test('should start with the constructor name', () {
      expect(data, contains('Comment {'));
    });

    test('should contain the instance properties', () {
      expect(data, contains('"comment_author":"Cédric Belin"'));
      expect(data, contains('"comment_content":"A user comment."'));
      expect(data, contains('"comment_date_gmt":"2000-01-01T00:00:00.000Z"'));
      expect(data, contains('"comment_type":"pingback"'));
      expect(data, contains('"referrer":"https://belin.io"'));
    });
  });
});
