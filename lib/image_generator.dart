library image_generator;
import 'dart:async';
import 'dart:io';
import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:build/build.dart';
import 'package:yaml/yaml.dart';
import 'package:source_gen/source_gen.dart';
/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

/*
class AssetGenerator extends Generator {
  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    final yamlContent = await buildStep.readAsString(buildStep.inputId);
    final yamlMap = loadYaml(yamlContent) as YamlMap;

    final assets = yamlMap['asset_generator'] as YamlMap;

    final usageCounts = <String, int>{};
    for (var image in assets['images']) {
      usageCounts[image] = 0;
    }

    await _traverseAndCountUsages(usageCounts);

    final buffer = StringBuffer();
    buffer.writeln("class Assets {");

    for (var image in assets['images']) {
      final name = image.split('/').last.split('.').first;
      final count = usageCounts[image] ?? 0;
      buffer.writeln("  static const String $name = '$image'; // Used $count times");
    }

    buffer.writeln("}");

    return buffer.toString();
  }

  Future<void> _traverseAndCountUsages(Map<String, int> usageCounts) async {
    final dir = Directory('lib');
    final dartFiles = dir
        .listSync(recursive: true)
        .where((file) => file.path.endsWith('.dart'));

    for (var file in dartFiles) {
      final content = File(file.path).readAsStringSync();
      final result = parseString(content: content, featureSet: FeatureSet.fromEnableFlags([]));

      result.unit.visitChildren(_UsageVisitor(usageCounts));
    }
  }
}

class _UsageVisitor extends RecursiveAstVisitor<void> {
  final Map<String, int> usageCounts;

  _UsageVisitor(this.usageCounts);

  @override
  void visitAdjacentStrings(AdjacentStrings  node) {
    final value = node.stringValue;
    if (value != null && usageCounts.containsKey(value)) {
      usageCounts[value] = usageCounts[value]! + 1;
    }
    super.visitAdjacentStrings(node);
  }
}

*/




class AssetGenerator extends Generator {
  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    final yamlContent = await buildStep.readAsString(buildStep.inputId);
    final yamlMap = loadYaml(yamlContent) as YamlMap;

    final assets = yamlMap['image_generator'] as YamlMap;

    final usageCounts = <String, int>{};
    for (var image in assets['images']) {
      usageCounts[image] = 0;
    }

    await _traverseAndCountUsages(usageCounts);

    final buffer = StringBuffer();
    buffer.writeln("class Assets {");

    for (var image in assets['images']) {
      final name = image.split('/').last.split('.').first;
      final count = usageCounts[image] ?? 0;
      buffer.writeln("  static const String $name = '$image'; // Used $count times");
    }

    buffer.writeln("}");

    return buffer.toString();
  }

  Future<void> _traverseAndCountUsages(Map<String, int> usageCounts) async {
    final dir = Directory('lib');
    final dartFiles = dir
        .listSync(recursive: true)
        .where((file) => file.path.endsWith('.dart'));

    for (var file in dartFiles) {
      final content = File(file.path).readAsStringSync();
      final result = parseString(
        content: content,
        featureSet: FeatureSet.latestLanguageVersion(), // Use named constructor
      );

      result.unit.visitChildren(_UsageVisitor(usageCounts));
    }
  }
}

class _UsageVisitor extends RecursiveAstVisitor<void> {
  final Map<String, int> usageCounts;

  _UsageVisitor(this.usageCounts);

@override
  void visitAdjacentStrings(AdjacentStrings  node) {
    final value = node.stringValue;
    if (value != null && usageCounts.containsKey(value)) {
      usageCounts[value] = usageCounts[value]! + 1;
    }
    super.visitAdjacentStrings(node);
  }
}
