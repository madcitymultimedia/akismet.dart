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
        'referrer': 'https://belin.io/'
      });

      expect(comment.author, const isInstanceOf<Author>());
      expect(comment.author.name, equals('Cédric Belin'));
      expect(comment.content, equals('A user comment.'));
      expect(comment.date, const isInstanceOf<DateTime>());
      expect(comment.referrer, equals(new Uri.https('belin.io', '/')));
      expect(comment.type, equals(CommentType.trackback));
    });
  });

  group('.toJson()', () {
    test('should return only the author info with a newly created instance', () {
      var data = new Comment(new Author('127.0.0.1', 'Doom/6.6.6')).toJson();
      expect(data, hasLength(2));
      expect(data['user_agent'], equals('Doom/6.6.6'));
      expect(data['user_ip'], equals('127.0.0.1'));
    });

    test('should return a non-empty map with an initialized instance', () {
      var data = new Comment(
        new Author('127.0.0.1', 'Doom/6.6.6', name: 'Cédric Belin'),
        content: 'A user comment.',
        date: DateTime.parse('2000-01-01T00:00:00.000Z'),
        referrer: new Uri.https('belin.io', '/'),
        type: CommentType.pingback
      ).toJson();

      expect(data, hasLength(7));
      expect(data['comment_author'], 'Cédric Belin');
      expect(data['comment_content'], 'A user comment.');
      expect(data['comment_date_gmt'], '2000-01-01T00:00:00.000Z');
      expect(data['comment_type'], 'pingback');
      expect(data['referrer'], 'https://belin.io/');
      expect(data['user_agent'], equals('Doom/6.6.6'));
      expect(data['user_ip'], equals('127.0.0.1'));
    });
  });

  group('.toString()', () {
    var data = new Comment(
      new Author('127.0.0.1', 'Doom/6.6.6', name: 'Cédric Belin'),
      content: 'A user comment.',
      date: DateTime.parse('2000-01-01T00:00:00.000Z'),
      referrer: new Uri.https('belin.io', '/'),
      type: CommentType.pingback
    ).toString();

    test('should start with the class name', () {
      expect(data, contains('Comment {'));
    });

    test('should contain the instance properties', () {
      expect(data, contains('"comment_author":"Cédric Belin"'));
      expect(data, contains('"comment_content":"A user comment."'));
      expect(data, contains('"comment_date_gmt":"2000-01-01T00:00:00.000Z"'));
      expect(data, contains('"comment_type":"pingback"'));
      expect(data, contains('"referrer":"https://belin.io/"'));
      expect(data, contains('"user_agent":"Doom/6.6.6"'));
      expect(data, contains('"user_ip":"127.0.0.1"'));
    });
  });
});
