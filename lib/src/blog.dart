part of akismet;

/// Represents the front page or home URL transmitted when making requests.
class Blog {

  /// Creates a new blog.
  Blog([this.url]);

  /// Creates a new blog from the specified [map] in JSON format.
  Blog.fromJson(Map<String, String> map) {
    assert(map != null);

    if (map['blog'] != null) url = Uri.parse(map['blog']);
    if (map['blog_charset'] != null) charset = map['blog_charset'];
    if (map['blog_lang'] != null) language = map['blog_lang'];
  }

  /// The character encoding for the values included in comments.
  String charset;

  /// The language(s) in use on the blog or site, in ISO 639-1 format, comma-separated.
  String language;

  /// The blog or site URL.
  Uri url;

  /// Converts this object to a map in JSON format.
  Map<String, String> toJson() {
    var map = {};
    if (url != null) map['blog'] = url.toString();
    if (charset != null) map['blog_charset'] = charset;
    if (language != null) map['blog_lang'] = language;
    return map;
  }

  /// Returns a string representation of this object.
  @override String toString() => '${runtimeType} ${JSON.encode(this)}';
}
