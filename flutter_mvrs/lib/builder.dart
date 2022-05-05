library flutter_mvrs.builder;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'generator/model_generator.dart';

Builder modelBuilder(BuilderOptions options) {
  try {
    return SharedPartBuilder([ModelGenerator()], 'model_generator');
  } catch (e) {
    print(e.toString());
    throw StateError("Error in model builder");
  }
}
