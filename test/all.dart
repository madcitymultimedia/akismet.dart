import 'package:test/test.dart';

import 'author_test.dart' as author_test;
import 'blog_test.dart' as blog_test;
import 'client_test.dart' as client_test;
import 'comment_test.dart' as comment_test;

/// Tests all the features of the package.
void main() {
  group('Author', author_test.main);
  group('Blog', blog_test.main);
  group('Client', client_test.main);
  group('Comment', comment_test.main);
}
