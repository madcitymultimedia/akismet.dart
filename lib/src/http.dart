/// Provides the HTTP client.
library akismet.http;

import 'dart:async';
import 'dart:io' show HttpHeaders;
import 'package:http/http.dart' as http;

import 'core.dart';
import 'io.dart'
  if (dart.library.html) 'io/browser.dart'
  if (dart.library.io) 'io/vm.dart';

part 'http/client.dart';
