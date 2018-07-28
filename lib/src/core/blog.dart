part of akismet.core;

/// Converts the specified comma-separated list to a list of [String] instances.
List<String> _languagesFromJson(String languages) => languages.split(',').map((lang) => lang.trim()).toList();

/// Converts the specified language list to a comma-separated one.
String _languagesToJson(List<String> languages) => languages.isEmpty ? null : languages.join(',');

/// Represents the front page or home URL transmitted when making requests.
@JsonSerializable()
class Blog {

  /// Creates a new blog.
  Blog(this.url, {this.charset, Iterable<String> languages}): languages = List<String>.from(languages ?? const <String>[]);

  /// Creates a new blog from the specified [map] in JSON format.
  factory Blog.fromJson(Map<String, dynamic> map) => _$BlogFromJson(map);

  /// The character encoding for the values included in comments.
  @JsonKey(includeIfNull: false, name: 'blog_charset')
  final String charset;

  /// The languages in use on the blog or site, in ISO 639-1 format.
  @JsonKey(fromJson: _languagesFromJson, includeIfNull: false, name: 'blog_lang', toJson: _languagesToJson)
  final List<String> languages;

  /// The blog or site URL.
  @JsonKey(name: 'blog')
  final Uri url;

  /// Converts this object to a [Map] in JSON format.
  Map<String, dynamic> toJson() => _$BlogToJson(this);

  /// Returns a string representation of this object.
  @override
  String toString() => 'Blog ${json.encode(this)}';
}
