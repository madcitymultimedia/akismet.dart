/// Prevent comment spam using the [Akismet](https://akismet.com) service.
library akismet;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'io.dart'
  if (dart.library.html) 'src/io/browser.dart'
  if (dart.library.io) 'src/io/vm.dart';

part 'src/author.dart';
part 'src/blog.dart';
part 'src/client.dart';
part 'src/comment.dart';

/// The version number of this package.
const String _version = '3.2.0';
