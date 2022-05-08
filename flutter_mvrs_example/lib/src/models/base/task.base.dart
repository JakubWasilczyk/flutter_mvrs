// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../task.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

class BaseTask extends BaseModel<String?> {
  final String _title;
  final String _subtitle;

  BaseTask({
    String? id,
    required String title,
    required String subtitle,
  })  : _title = title,
        _subtitle = subtitle,
        super(id: id);

  //GETTERS
  String get title => get('title', _title);
  String get subtitle => get('subtitle', _subtitle);

  //SETTERS
  set title(String value) => set('title', value);
  set subtitle(String value) => set('subtitle', value);

  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
      };

  static Task fromJson(Map<String, dynamic> json) => Task(
        title: json['title'],
        subtitle: json['subtitle'],
      );
}
