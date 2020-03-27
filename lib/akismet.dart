/// Prevent comment spam using the [Akismet](https://akismet.com) service.
library akismet;

import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'src/version.dart';

export 'package:http/http.dart' show ClientException;

part 'akismet.g.dart';
part 'src/author.dart';
part 'src/blog.dart';
part 'src/client.dart';
part 'src/comment.dart';
