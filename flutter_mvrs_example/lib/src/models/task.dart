import 'package:flutter_mvrs/flutter_mvrs.dart';

part 'base/task.base.dart';

@Model(
  toJsonIgnore: ['id'],
  toJsonAdditional: {
    "title": ".toString()",
  },
)
class Task extends BaseTask {
  final bool exists;

  Task({
    String? id,
    required String title,
    required String subtitle,
    bool isChecked = false,
    this.exists = false,
  }) : super(
          id: id,
          title: title,
          subtitle: subtitle,
        );

  factory Task.fromJson(Map<String, dynamic> json) => BaseTask.fromJson(json);
}
