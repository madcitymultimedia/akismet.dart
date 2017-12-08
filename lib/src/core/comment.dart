part of akismet.core;

/// Represents a comment submitted by an author.
class Comment {

  /// Creates a new comment.
  Comment(this.author, {this.content = '', this.date, this.permalink, this.postModified, this.referrer, this.type = ''});

  /// Creates a new comment from the specified [map] in JSON format.
  Comment.fromJson(Map<String, String> map):
    author = map.keys.any((key) => key.startsWith('comment_author') || key.startsWith('user')) ? new Author.fromJson(map) : null,
    content = map['comment_content'] ?? '',
    date = map['comment_date_gmt'] != null ? DateTime.parse(map['comment_date_gmt']) : null,
    permalink = map['permalink'] != null ? Uri.parse(map['permalink']) : null,
    postModified = map['comment_post_modified_gmt'] != null ? DateTime.parse(map['comment_post_modified_gmt']) : null,
    referrer = map['referrer'] != null ? Uri.parse(map['referrer']) : null,
    type = map['comment_type'] ?? '';

  /// The comment's author.
  final Author author;

  /// The comment's content.
  final String content;

  /// The UTC timestamp of the creation of the comment.
  final DateTime date;

  /// The permanent location of the entry the comment is submitted to.
  final Uri permalink;

  /// The UTC timestamp of the publication time for the post, page or thread on which the comment was posted.
  final DateTime postModified;

  /// The URL of the webpage that linked to the entry being requested.
  final Uri referrer;

  /// The comment's type.
  /// This string value specifies a [CommentType] constant or a made up value like `"registration"`.
  final String type;

  /// Converts this object to a map in JSON format.
  Map<String, String> toJson() {
    var map = author.toJson();
    if (content.isNotEmpty) map['comment_content'] = content;
    if (date != null) map['comment_date_gmt'] = date.toIso8601String();
    if (postModified != null) map['comment_post_modified_gmt'] = postModified.toIso8601String();
    if (type.isNotEmpty) map['comment_type'] = type;
    if (permalink != null) map['permalink'] = permalink.toString();
    if (referrer != null) map['referrer'] = referrer.toString();
    return map;
  }

  /// Returns a string representation of this object.
  @override
  String toString() => 'Comment ${JSON.encode(this)}';
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
