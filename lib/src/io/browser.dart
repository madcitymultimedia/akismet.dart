import 'package:http/http.dart' as http;
import 'package:http/browser_client.dart';

/// The version of the current platform.
String get platformVersion => '2.0.0';

/// Creates a new HTTP client.
http.Client newHttpClient() => BrowserClient();
