import 'core/author_test.dart' as author_test;
import 'core/blog_test.dart' as blog_test;
import 'core/comment_test.dart' as comment_test;
import 'http/client_test.dart' as client_test;

/// Tests all the features of the package.
void main() {
  // akismet.core
  author_test.main();
  blog_test.main();
  comment_test.main();

  // akismet.http
  client_test.main();
}
