// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Author _$AuthorFromJson(Map<String, dynamic> json) {
  return Author(
    json['user_ip'] as String,
    json['user_agent'] as String,
    email: json['comment_author_email'] as String,
    name: json['comment_author'] as String,
    role: json['user_role'] as String,
    url: json['comment_author_url'] == null
        ? null
        : Uri.parse(json['comment_author_url'] as String),
  );
}

Map<String, dynamic> _$AuthorToJson(Author instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('comment_author_email', instance.email);
  val['user_ip'] = instance.ipAddress;
  writeNotNull('comment_author', instance.name);
  writeNotNull('user_role', instance.role);
  writeNotNull('comment_author_url', instance.url?.toString());
  val['user_agent'] = instance.userAgent;
  return val;
}

Blog _$BlogFromJson(Map<String, dynamic> json) {
  return Blog(
    json['blog'] == null ? null : Uri.parse(json['blog'] as String),
    charset: json['blog_charset'] as String,
    languages: Blog._languagesFromJson(json['blog_lang'] as String),
  );
}

Map<String, dynamic> _$BlogToJson(Blog instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('blog_charset', instance.charset);
  writeNotNull('blog_lang', Blog._languagesToJson(instance.languages));
  val['blog'] = instance.url?.toString();
  return val;
}

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    json['author'] == null
        ? null
        : Author.fromJson(json['author'] as Map<String, dynamic>),
    content: json['comment_content'] as String,
    date: json['comment_date_gmt'] == null
        ? null
        : DateTime.parse(json['comment_date_gmt'] as String),
    permalink: json['permalink'] == null
        ? null
        : Uri.parse(json['permalink'] as String),
    postModified: json['comment_post_modified_gmt'] == null
        ? null
        : DateTime.parse(json['comment_post_modified_gmt'] as String),
    referrer:
        json['referrer'] == null ? null : Uri.parse(json['referrer'] as String),
    type: json['comment_type'] as String,
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('author', Comment._authorToJson(instance.author));
  writeNotNull('comment_content', instance.content);
  writeNotNull('comment_date_gmt', instance.date?.toIso8601String());
  writeNotNull('permalink', instance.permalink?.toString());
  writeNotNull(
      'comment_post_modified_gmt', instance.postModified?.toIso8601String());
  writeNotNull('referrer', instance.referrer?.toString());
  writeNotNull('comment_type', instance.type);
  return val;
}
