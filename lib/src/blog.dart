part of akismet;

/// Represents the front page or home URL transmitted when making requests.
class Blog {

  /// Creates a new blog.
  Blog({this.charset, languages, url}) {
    if (languages != null) this.languages = languages is List<String> ? languages : _parseLanguages(languages.toString());
    if (url != null) this.url = url is Uri ? url : Uri.parse(url.toString());
  }

  /// Creates a new blog from the specified [map] in JSON format.
  Blog.fromJson(Map<String, String> map) {
    assert(map != null);
    if (map['blog'] != null) url = Uri.parse(map['blog']);
    if (map['blog_charset'] != null) charset = map['blog_charset'];
    if (map['blog_lang'] != null) languages = _parseLanguages(map['blog_lang']);
  }

  /// The character encoding for the values included in comments.
  String charset;

  /// The languages in use on the blog or site, in ISO 639-1 format, comma-separated.
  List<String> languages = [];

  /// The blog or site URL.
  Uri url;

  /// Converts this object to a map in JSON format.
  Map<String, String> toJson() {
    var map = <String, String>{};
    if (url != null) map['blog'] = url.toString();
    if (charset != null) map['blog_charset'] = charset;
    if (languages != null && languages.isNotEmpty) map['blog_lang'] = languages.join(',');
    return map;
  }

  /// Returns a string representation of this object.
  @override
  String toString() => '$runtimeType ${JSON.encode(this)}';

  /// Parses the specified comma-separated list of [languages] into a [List] object.
  List<String> _parseLanguages(String languages) => languages
    .split(',')
    .map((language) => language.trim())
    .where((language) => language.isNotEmpty)
    .toList();
}
