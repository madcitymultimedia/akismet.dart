part of akismet;

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
