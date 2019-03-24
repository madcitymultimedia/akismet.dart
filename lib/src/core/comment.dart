part of '../core.dart';

/// Represents a comment submitted by an author.
@JsonSerializable(includeIfNull: false)
class Comment {

  /// Creates a new comment.
  Comment(this.author, {this.content, this.date, this.permalink, this.postModified, this.referrer, this.type});

  /// Creates a new comment from the specified [map] in JSON format.
  factory Comment.fromJson(Map<String, dynamic> map) {
    map['author'] = map.keys.any((key) => key.startsWith('comment_author') || key.startsWith('user')) ? map : null;
    return _$CommentFromJson(map);
  }

  /// The comment's author.
  @JsonKey(toJson: _authorToJson)
  final Author author;

  /// The comment's content.
  @JsonKey(name: 'comment_content')
  final String content;

  /// The UTC timestamp of the creation of the comment.
  @JsonKey(name: 'comment_date_gmt')
  final DateTime date;

  /// The permanent location of the entry the comment is submitted to.
  final Uri permalink;

  /// The UTC timestamp of the publication time for the post, page or thread on which the comment was posted.
  @JsonKey(name: 'comment_post_modified_gmt')
  final DateTime postModified;

  /// The URL of the webpage that linked to the entry being requested.
  final Uri referrer;

  /// The comment's type.
  /// This string value specifies a [CommentType] constant or a made up value like `"registration"`.
  @JsonKey(name: 'comment_type')
  final String type;

  /// Converts this object to a [Map] in JSON format.
  Map<String, dynamic> toJson() {
    final map = _$CommentToJson(this);
    if (map.containsKey('author')) map..addAll(map['author'])..remove('author');
    return map;
  }

  /// Converts the specified [Author] instance to a JSON object.
  static Map<String, dynamic> _authorToJson(Author author) => author.toJson();
}

/// Specifies the type of a comment.
abstract class CommentType {

  /// A blog post.
  static const String blogPost = 'blog-post';

  /// A blog comment.
  static const String comment = 'comment';

  /// A contact form or feedback form submission.
  static const String contactForm = 'contact-form';

  /// A top-level forum post.
  static const String forumPost = 'forum-post';

  /// A message sent between just a few users.
  static const String message = 'message';

  /// A [pingback](https://en.wikipedia.org/wiki/Pingback) post.
  static const String pingback = 'pingback';

  /// A reply to a top-level forum post.
  static const String reply = 'reply';

  /// A new user account.
  static const String signup = 'signup';

  /// A [trackback](https://en.wikipedia.org/wiki/Trackback) post.
  static const String trackback = 'trackback';

  /// A [Twitter](https://twitter.com) message.
  static const String tweet = 'tweet';
}
