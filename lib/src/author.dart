part of '../akismet.dart';

/// Represents the author of a comment.
@JsonSerializable()
class Author {

  /// Creates a new author.
  Author(this.ipAddress, this.userAgent, {this.email, this.name, this.role, this.url});

  /// Creates a new author from the specified [map] in JSON format.
  factory Author.fromJson(Map<String, dynamic> map) => _$AuthorFromJson(map);

  /// The author's mail address.
  /// If you set it to `"akismet-guaranteed-spam@example.com"`, Akismet will always return `true`.
  @JsonKey(includeIfNull: false, name: 'comment_author_email')
  final String email;

  /// The author's IP address.
  @JsonKey(name: 'user_ip')
  final String ipAddress;

  /// The author's name.
  /// If you set it to `"viagra-test-123"`, Akismet will always return `true`.
  @JsonKey(includeIfNull: false, name: 'comment_author')
  final String name;

  /// The author's role.
  /// If you set it to `"administrator"`, Akismet will always return `false`.
  @JsonKey(includeIfNull: false, name: 'user_role')
  final String role;

  /// The URL of the author's website.
  @JsonKey(includeIfNull: false, name: 'comment_author_url')
  final Uri url;

  /// The author's user agent, that is the string identifying the Web browser used to submit comments.
  @JsonKey(name: 'user_agent')
  final String userAgent;

  /// Converts this object to a [Map] in JSON format.
  Map<String, dynamic> toJson() => _$AuthorToJson(this);

  /// Returns a string representation of this object.
  @override
  String toString() => 'Author ${json.encode(this)}';
}
