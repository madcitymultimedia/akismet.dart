part of akismet;

/// Represents a comment submitted by an author.
class Comment {

  /// Creates a new comment.
  Comment([this.author, this.content = '', this.type = '']);

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
  String toString() => '$runtimeType ${JSON.encode(this)}';
}
