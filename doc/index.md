# Akismet <small>for Dart</small>
![Runtime](https://img.shields.io/badge/dart-%3E%3D2.3-brightgreen.svg) ![Release](https://img.shields.io/pub/v/akismet.svg) ![License](https://img.shields.io/badge/license-MIT-blue.svg) ![Coverage](https://coveralls.io/repos/github/cedx/akismet.dart/badge.svg) ![Build](https://travis-ci.com/cedx/akismet.dart.svg)

![Akismet](img/akismet.png)

## Stop spam
Used by millions of websites, [Akismet](https://akismet.com) filters out hundreds of millions of spam comments from the Web every day.
Add Akismet to your [Dart](https://dart.dev) applications so you don't have to worry about spam again.

## Quick start

### Get a developer key
You first need to [sign up for a developer key](https://akismet.com/signup/?connect=yes&plan=developer).
This will give you access to the API and will allow Akismet to monitor its results to make sure things are running as smoothly as possible.

!!! warning
    All Akismet endpoints require an API key. If you are not already registered,
    [join the developer program](https://akismet.com/signup/?connect=yes&plan=developer).

### Get the library
Append the following line to your project's `pubspec.yaml` file:

```yaml
dependencies:
  akismet: *
```

Install the latest version of **Akismet for Dart** with [Pub](https://dart.dev/tools/pub/cmd):

```shell
pub get
```

For detailed instructions, see the [installation guide](installation.md).
