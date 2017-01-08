part of akismet;

/// Represents a comment submitted by an author.
class Comment {

  /// Creates a new comment.
  Comment({author, this.content, date, permalink, postModified, referrer, this.type}) {
    if (author != null) this.author = author is Author ? author : new Author(name: author.toString());
    if (date != null) this.date = date is DateTime ? date : DateTime.parse(date.toString());
    if (permalink != null) this.permalink = permalink is Uri ? permalink : Uri.parse(permalink.toString());
    if (postModified != null) this.postModified = postModified is DateTime ? postModified : DateTime.parse(postModified.toString());
    if (referrer != null) this.referrer = referrer is Uri ? referrer : Uri.parse(referrer.toString());
  }

  /// Creates a new comment from the specified [map] in JSON format.
  Comment.fromJson(Map<String, String> map) {
    assert(map != null);
    if (map.keys.any((key) => key.startsWith('comment_author') || key.startsWith('user'))) author = new Author.fromJson(map);
    if (map['comment_content'] != null) content = map['comment_content'];
    if (map['comment_date_gmt'] != null) date = DateTime.parse(map['comment_date_gmt']);
    if (map['comment_post_modified_gmt'] != null) postModified = DateTime.parse(map['comment_post_modified_gmt']);
    if (map['comment_type'] != null) type = map['comment_type'];
    if (map['permalink'] != null) permalink = Uri.parse(map['permalink']);
    if (map['referrer'] != null) referrer = Uri.parse(map['referrer']);
  }

  /// The comment's author.
  Author author;

  /// The comment's content.
  String content;

  /// The UTC timestamp of the creation of the comment.
  DateTime date;

  /// The permanent location of the entry the comment is submitted to.
  Uri permalink;

  /// The UTC timestamp of the publication time for the post, page or thread on which the comment was posted.
  DateTime postModified;

  /// The URL of the webpage that linked to the entry being requested.
  Uri referrer;

  /// The comment's type.
  /// This string value specifies a [CommentType] constant or a made up value like `"registration"`.
  String type;

  /// Converts this object to a map in JSON format.
  Map<String, String> toJson() {
    var map = author != null ? author.toJson() : <String, String>{};
    if (content != null) map['comment_content'] = content;
    if (date != null) map['comment_date_gmt'] = date.toIso8601String();
    if (postModified != null) map['comment_post_modified_gmt'] = postModified.toIso8601String();
    if (type != null) map['comment_type'] = type;
    if (permalink != null) map['permalink'] = permalink.toString();
    if (referrer != null) map['referrer'] = referrer.toString();
    return map;
  }

  /// Returns a string representation of this object.
  @override
  String toString() => '$runtimeType ${JSON.encode(this)}';
}

/// Specifies the type of a comment.
abstract class CommentType {

  /// A standard comment.
  static const String comment = 'comment';

  /// A [pingback](https://en.wikipedia.org/wiki/Pingback) comment.
  static const String pingback = 'pingback';

  /// A [trackback](https://en.wikipedia.org/wiki/Trackback) comment.
  static const String trackback = 'trackback';
}
