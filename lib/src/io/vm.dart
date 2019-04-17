import 'dart:io' show Platform;

/// The version of the current platform.
String get platformVersion => Platform.version.split(' ').first;
