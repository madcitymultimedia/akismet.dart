part of akismet;

/// Specifies the type of a comment.
abstract class CommentType {

  /// A standard comment.
  static const String comment = 'comment';

  /// A [pingback](https://en.wikipedia.org/wiki/Pingback) comment.
  static const String pingback = 'pingback';

  /// A [trackback](https://en.wikipedia.org/wiki/Trackback) comment.
  static const String trackback = 'trackback';
}
