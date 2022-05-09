// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../task.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

class BaseTask extends BaseModel<String?> {
  final String _title;
  final String _subtitle;
  final bool _isChecked;

  BaseTask({
    String? id,
    required String title,
    required String subtitle,
    bool isChecked = false,
  })  : _title = title,
        _subtitle = subtitle,
        _isChecked = isChecked,
        super(id: id);

  //GETTERS
  String get title => get('title', _title);
  String get subtitle => get('subtitle', _subtitle);
  bool get isChecked => get('isChecked', _isChecked);

  //SETTERS
  set title(String value) => set('title', value);
  set subtitle(String value) => set('subtitle', value);
  set isChecked(bool value) => set('isChecked', value);

  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
        'isChecked': isChecked,
      };

  static Task fromJson(Map<String, dynamic> json) => Task(
        id: json['id'],
        title: json['title'],
        subtitle: json['subtitle'],
        isChecked: json['isChecked'],
      );
}
