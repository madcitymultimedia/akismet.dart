/// Prevent comment spam using the [Akismet](https://akismet.com) service.
library akismet;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

part 'src/author.dart';
part 'src/blog.dart';
part 'src/client.dart';
part 'src/comment.dart';
part 'src/comment_type.dart';

/// The version number of the package.
const String VERSION = '1.0.0';
