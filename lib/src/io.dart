/// Provides the I/O support.
library akismet.io;

import 'package:http/http.dart' as http;

/// The version of the current platform.
String get platformVersion => '0.0.0';

/// Creates a new HTTP client.
http.Client newHttpClient() => null;
