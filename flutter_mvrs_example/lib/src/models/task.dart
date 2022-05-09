import 'package:flutter_mvrs/flutter_mvrs.dart';

part 'base/task.base.dart';

@Model(
  toJsonIgnore: ['id'],
  defaultValues: {
    "testType": "const TestType(\"alias\")",
  },
)
class Task extends BaseTask {
  final bool exists;

  Task({
    String? id,
    required String title,
    required String subtitle,
    bool isChecked = false,
    TestType? testType,
    this.exists = false,
  }) : super(
          id: id,
          title: title,
          subtitle: subtitle,
          isChecked: isChecked,
        );

  factory Task.fromJson(Map<String, dynamic> json) => BaseTask.fromJson(json);
}

class TestType {
  final String hello;

  const TestType(this.hello);
}
