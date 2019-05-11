import 'dart:async';
import 'dart:io';
import 'package:grinder/grinder.dart';
import 'package:grinder_coveralls/grinder_coveralls.dart';

/// Starts the build system.
Future<void> main(List<String> args) => grind(args);

@DefaultTask('Builds the project')
@Depends(version)
void build() => Pub.run('build_runner', arguments: ['build', '--delete-conflicting-outputs']);

@Task('Deletes all generated files and reset any saved state')
void clean() {
  defaultClean();
  ['.dart_tool', 'doc/api', webDir.path].map(getDir).forEach(delete);
  FileSet.fromDir(getDir('var'), pattern: '*.{info,json}', recurse: true).files.forEach(delete);
}

@Task('Uploads the results of the code coverage')
Future<void> coverage() async {
  final report = getFile('var/lcov.info');
  if (report.existsSync()) return uploadCoverage(await report.readAsString());
}

@Task('Builds the documentation')
Future<void> doc() async {
  for (final path in ['CHANGELOG.md', 'LICENSE.md']) await getFile(path).copy('doc/about/${path.toLowerCase()}');
  DartDoc.doc();
  run('mkdocs', arguments: ['build', '--config-file=doc/mkdocs.yaml']);
  ['doc/about/changelog.md', 'doc/about/license.md', '${webDir.path}/mkdocs.yaml'].map(getFile).forEach(delete);
}

@Task('Fixes the coding standards issues')
void fix() => DartFmt.format(existingSourceDirs);

@Task('Performs the static analysis of source code')
void lint() => Analyzer.analyze(existingSourceDirs);

@Task('Runs the test suites')
Future<void> test() async {
  final args = context.invocation.arguments;
  return (args.hasOption('platform') ? args.getOption('platform') : 'vm') == 'browser'
    ? Pub.runAsync('build_runner', arguments: ['test', '--delete-conflicting-outputs', '--release', '--', '--platform=chrome'])
    : collectCoverage(getDir('test'), reportOn: [libDir.path], saveAs: 'var/lcov.info');
}

@Task('Upgrades the project to the latest revision')
void upgrade() {
  run('git', arguments: ['reset', '--hard']);
  run('git', arguments: ['fetch', '--all', '--prune']);
  run('git', arguments: ['pull', '--rebase']);
  Pub.upgrade();
}

@Task('Updates the version number contained in the sources')
Future<void> version() async {
  final file = getFile('lib/src/io/browser.dart');
  return file.writeAsString((await file.readAsString()).replaceAll(
    RegExp(r"platformVersion => '\d+(\.\d+){2}'"),
    "platformVersion => '${Platform.version.split(' ').first}'"
  ));
}

@Task('Watches for file changes')
void watch() => Pub.run('build_runner', arguments: ['watch', '--delete-conflicting-outputs']);
