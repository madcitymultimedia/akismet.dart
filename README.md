# Akismet for Dart
![Release](https://img.shields.io/pub/v/akismet.svg) ![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg) ![Code quality](https://img.shields.io/codacy/grade/5886b76275947e58f51f11e9814fc56.svg) ![Build](https://img.shields.io/travis/cedx/akismet.dart.svg)

Prevent comment spam using the [Akismet](https://akismet.com) service, in [Dart](https://www.dartlang.org).

## Features
- [Key Verification](https://akismet.com/development/api/#verify-key): checks an Akismet API key and gets a value indicating whether it is valid.
- [Comment Check](https://akismet.com/development/api/#comment-check): checks a comment and gets a value indicating whether it is spam.
- [Submit Spam](https://akismet.com/development/api/#submit-spam): submits a comment that was not marked as spam but should have been.
- [Submit Ham](https://akismet.com/development/api/#submit-ham): submits a comment that was incorrectly marked as spam but should not have been.

## Requirements
The latest [Dart SDK](https://www.dartlang.org) and [Pub](https://pub.dartlang.org) versions.

## See Also
- [API Reference](https://cedx.github.io/akismet.dart)
- [Code Quality](https://www.codacy.com/app/cedx/akismet-dart)
- [Continuous Integration](https://travis-ci.org/cedx/akismet.dart)

## License
[Akismet for Dart](https://github.com/cedx/akismet.dart) is distributed under the Apache License, version 2.0.
