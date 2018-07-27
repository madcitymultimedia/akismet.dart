part of akismet.core;

/// Converts the specified comma-separated list to a list of [String] instances.
List<String> _languagesFromJson(String languages) => languages.split(',').map((lang) => lang.trim()).toList();

/// Converts the specified language list to a comma-separated one.
String _languagesToJson(List<String> languages) => languages.join(',');

/// Represents the front page or home URL transmitted when making requests.
@JsonSerializable()
class Blog {

  /// Creates a new blog.
  Blog(Object url, {this.charset, Iterable<String> languages}):
    languages = List<String>.from(languages ?? const <String>[]),
    url = url is Uri ? url : Uri.parse(url.toString());

  /// Creates a new blog from the specified [map] in JSON format.
  Blog.fromJson(Map<String, dynamic> map):
    charset = map['blog_charset'] ?? '',
    languages = map['blog_lang'] != null ? map['blog_lang'].split(',').map((lang) => lang.trim()).where((lang) => lang.isNotEmpty).toList() : <String>[],
    url = map['blog'] != null ? Uri.tryParse(map['blog']) : null;

  /// The character encoding for the values included in comments.
  @JsonKey(includeIfNull: false, name: 'blog_charset')
  final String charset;

  /// The languages in use on the blog or site, in ISO 639-1 format.
  @JsonKey(fromJson: _languagesFromJson, includeIfNull: false, name: 'blog_lang', toJson: _languagesToJson)
  final List<String> languages;

  /// The blog or site URL.
  @JsonKey(name: 'blog')
  final Uri url;

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => _$BlogToJson(this);

  /// Returns a string representation of this object.
  @override
  String toString() => 'Blog ${json.encode(this)}';
}
