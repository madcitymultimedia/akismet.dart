# Installation

## Requirements
You need the latest [Dart SDK](https://www.dartlang.org) and [Pub](https://pub.dartlang.org) versions in order to use the Akismet library.

If you plan to play with the sources, you will also need the latest [Grinder](http://google.github.io/grinder.dart) and [Material for MkDocs](https://squidfunk.github.io/mkdocs-material) versions.

## Installing with Pub package manager

### 1. Depend on it
Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  akismet: *
  http: *
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
