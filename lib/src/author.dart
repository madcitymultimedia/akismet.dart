part of akismet;

/// Represents the author of a comment.
class Author {

  /// Creates a new author.
  Author(this.ipAddress, this.userAgent, {this.email = '', this.name = '', this.role = '', url}) {
    if (url != null) this.url = url is Uri ? url : Uri.parse(url.toString());
  }

  /// Creates a new author from the specified [map] in JSON format.
  Author.fromJson(Map<String, String> map):
    email = map['comment_author_email'],
    ipAddress = map['user_ip'],
    name = map['comment_author'],
    role = map['user_role'],
    url = map['comment_author_url'] != null ? Uri.parse(map['comment_author_url']) : null,
    userAgent = map['user_agent'];

  /// The author's mail address.
  final String email;

  /// The author's IP address.
  final String ipAddress;

  /// The author's name.
  /// If you set it to `"viagra-test-123"`, Akismet will always return `true`.
  final String name;

  /// The author's role.
  /// If you set it to `"administrator"`, Akismet will always return `false`.
  final String role;

  /// The URL of the author's website.
  final Uri url;

  /// The author's user agent, that is the string identifying the Web browser used to submit comments.
  final String userAgent;

  /// Converts this object to a map in JSON format.
  Map<String, String> toJson() {
    var map = {
      'user_agent': userAgent,
      'user_ip': ipAddress
    };

    if (name.isNotEmpty) map['comment_author'] = name;
    if (email.isNotEmpty) map['comment_author_email'] = email;
    if (url != null) map['comment_author_url'] = url.toString();
    if (role.isNotEmpty) map['user_role'] = role;
    return map;
  }

  /// Returns a string representation of this object.
  @override
  String toString() => '$runtimeType ${JSON.encode(this)}';
}
