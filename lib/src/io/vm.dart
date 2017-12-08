import 'dart:io';
import 'package:http/http.dart' as http;

/// A reference to the HTTP client.
final http.Client httpClient = new http.IOClient();

/// The version of the current platform.
String get platformVersion => Platform.version.split(' ').first;
