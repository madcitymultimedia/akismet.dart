import 'dart:io';
import 'package:http/http.dart' as http;

/// The version of the current platform.
String get platformVersion => Platform.version.split(' ').first;

/// Creates a new HTTP client.
http.Client newHttpClient() => http.IOClient();
