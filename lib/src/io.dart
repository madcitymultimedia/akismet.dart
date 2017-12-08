/// Provides the I/O support.
library akismet.io;

import 'package:http/http.dart' as http;

/// A reference to the HTTP client.
final http.Client httpClient = null;

/// The version of the current platform.
String get platformVersion => '0.0.0';
