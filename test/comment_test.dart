import 'package:akismet/akismet.dart';
import 'package:test/test.dart';

/// Tests the features of the [Comment] class.
void main() => group('Comment', () {
  group('.fromJson()', () {
    test('should return an empty instance with an empty map', () {
      var comment = new Comment.fromJson(const {});
      expect(comment.author, isNull);
      expect(comment.content, isNull);
      expect(comment.date, isNull);
      expect(comment.referrer, isNull);
      expect(comment.type, isNull);
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
      var data = new Comment(
        author: new Author(name:  'Cédric Belin'),
        content: 'A user comment.',
        referrer: 'https://belin.io',
        type: CommentType.pingback
      ).toJson();

      expect(data, allOf(isMap, hasLength(4)));
      expect(data['comment_author'], 'Cédric Belin');
      expect(data['comment_content'], 'A user comment.');
      expect(data['comment_type'], 'pingback');
      expect(data['referrer'], 'https://belin.io');
    });
  });
});
