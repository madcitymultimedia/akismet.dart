/// Prevent comment spam using the [Akismet](https://akismet.com) service.
library akismet;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

part 'src/author.dart';
part 'src/blog.dart';
part 'src/client.dart';
part 'src/comment.dart';
part 'src/comment_type.dart';

/// The version number of the Dart runtime.
final String _dartVersion = Platform.version.replaceFirstMapped(new RegExp(r'^(\d+(\.\d+){2}).*'), (match) => match[1]);

/// The version number of the package.
const String _packageVersion = '1.0.0';
