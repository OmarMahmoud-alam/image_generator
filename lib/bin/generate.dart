library image_generator;

import 'package:image_generator/generator/generator.dart';
import 'package:image_generator/generator/generator_exception.dart';
import 'package:image_generator/utils/utils.dart';

Future<void> main(List<String> args) async {
  try {
    var generator = Generator();
    await generator.generateAsync();
  } on GeneratorException catch (e) {
    exitWithError(e.message);
  } catch (e) {
    exitWithError('Failed to generate localization files.\n$e');
  }
}
