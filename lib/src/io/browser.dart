import 'package:http/http.dart' as http;
import 'package:http/browser_client.dart';

/// A reference to the HTTP client.
final http.Client httpClient = new BrowserClient();

/// The version of the current platform.
String get platformVersion => '0.0.0';