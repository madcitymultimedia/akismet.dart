part of akismet.core;

/// Represents the front page or home URL transmitted when making requests.
class Blog {

  /// Creates a new blog.
  Blog(Object url, {this.charset = '', List<String> languages}):
    languages = new List.from(languages ?? const <String>[]),
    url = url is Uri ? url : Uri.parse(url.toString());

  /// Creates a new blog from the specified [map] in JSON format.
  Blog.fromJson(Map<String, String> map):
    charset = map['blog_charset'] ?? '',
    languages = map['blog_lang'] != null ? map['blog_lang'].split(',').map((lang) => lang.trim()).where((lang) => lang.isNotEmpty).toList() : [],
    url = map['blog'] != null ? Uri.parse(map['blog']) : null;

  /// The character encoding for the values included in comments.
  final String charset;

  /// The languages in use on the blog or site, in ISO 639-1 format.
  final List<String> languages;

  /// The blog or site URL.
  final Uri url;

  /// Converts this object to a map in JSON format.
  Map<String, String> toJson() {
    var map = {'blog': url.toString()};
    if (charset.isNotEmpty) map['blog_charset'] = charset;
    if (languages.isNotEmpty) map['blog_lang'] = languages.join(',');
    return map;
  }

  /// Returns a string representation of this object.
  @override
  String toString() => 'Blog ${JSON.encode(this)}';
}
