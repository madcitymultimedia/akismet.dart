import 'package:akismet/akismet.dart';
import 'package:test/test.dart';

/// Tests the features of the [Comment] class.
void main() => group('Comment', () {
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
group('Comment', () {

  group('constructor', () {
    test('should initialize the existing properties', () {
      var comment = new Comment({content: 'Hello World!', date: Date.now(), referrer: 'https://github.com/cedx/akismet.dart'});
      expect(comment.content, 'Hello World!');
      expect(comment.date instanceof Date);
      expect(comment.referrer, 'https://github.com/cedx/akismet.dart');
    });

    test('should not create new properties', () {
      expect(!('foo' in new Comment({foo: 'bar'})));
    });
  });

  group('.fromJson()', () {
    test('should return a null reference with a non-object JSON string', () {
      expect(Comment.fromJson('foo'), null);
    });

    test('should return an empty instance with an empty JSON object', () {
      var comment = Comment.fromJson({});
      expect(comment.author, null);
      expect(comment.content.length, 0);
      expect(comment.date, null);
      expect(comment.referrer.length, 0);
      expect(comment.type.length, 0);
    });

    test('should return an initialized instance with a non-empty JSON object', () {
      var comment = Comment.fromJson({
        comment_author: 'Cédric Belin',
        comment_content: 'A user comment.',
        comment_date_gmt: '2000-01-01T00:00:00.000Z',
        comment_type: 'trackback',
        referrer: 'https://belin.io'
      });

      expect(comment.author instanceof Author);
      expect(comment.author.name, 'Cédric Belin');
      expect(comment.content, 'A user comment.');
      expect(comment.date instanceof Date);
      expect(comment.referrer, 'https://belin.io');
      expect(comment.type, CommentType.TRACKBACK);
    });
  });

  group('#toJson()', () {
    test('should return an empty JSON object with a newly created instance', () {
      expect(Object.keys(new Comment().toJson()).length, 0);
    });

    test('should return a non-empty JSON object with a initialized instance', () {
      var data = new Comment({
        author: new Author({name: 'Cédric Belin'}),
        content: 'A user comment.',
        referrer: 'https://belin.io',
        type: CommentType.PINGBACK
      }).toJson();

      expect(data.comment_author, 'Cédric Belin');
      expect(data.comment_content, 'A user comment.');
      expect(data.comment_type, 'pingback');
      expect(data.referrer, 'https://belin.io');
    });
  });
});
*/
