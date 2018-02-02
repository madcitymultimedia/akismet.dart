# Installation

## Requirements
Before installing **Akismet for Dart**, you need to make sure you have the [Dart SDK](https://www.dartlang.org/tools/sdk)
and [Pub](https://www.dartlang.org/tools/pub), the Dart package manager, up and running.

!!! warning
    Akismet for Dart requires Dart >= **1.24.0**.

!!! info
    If you plan to play with the library sources, you will also need
    [Grinder](http://google.github.io/grinder.dart) and [Material for MkDocs](https://squidfunk.github.io/mkdocs-material).

You can verify if you're already good to go with the following commands:

```shell
dart --version
# Dart VM version: 1.24.3 (Wed Dec 13 16:10:39 2017) on "linux_x64"

pub --version
# Pub 1.24.3
```

## Installing with Pub package manager

### 1. Depend on it
Add this to your project's `pubspec.yaml` file:

```yaml
dependencies:
  akismet: *
```

### 2. Install it
Install this package and its dependencies from a command prompt:

```shell
pub get
```

### 3. Import it
Now in your [Dart](https://www.dartlang.org) code, you can use:

```dart
import 'package:akismet/akismet.dart';
```
