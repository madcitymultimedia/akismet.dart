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

/// The version number of the Dart runtime.
final String _dartVersion = Platform.version.substring(0, Platform.version.indexOf(' '));

/// The version number of the package.
const String _packageVersion = '1.1.0';
