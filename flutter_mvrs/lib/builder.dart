library flutter_mvrs.builder;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'generator/model_generator.dart';

Builder modelBuilder(BuilderOptions options) => PartBuilder([ModelGenerator()], '.base.*');
