import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:task_todo/core/utils/extensions.dart';

part 'task.g.dart';

@JsonSerializable()
class Task extends Equatable {
  final String title;
  final String color;
  final int icon;
  final List<dynamic>? todos;

//<editor-fold desc="Data Methods">
  const Task({
    required this.title,
    required this.color,
    required this.icon,
    this.todos,
  });

  Task copyWith({
    String? title,
    String? color,
    int? icon,
    List<dynamic>? todos,
  }) {
    return Task(
      title: title ?? this.title,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      todos: todos ?? this.todos,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'color': this.color,
      'icon': this.icon,
      'todos': this.todos,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] as String,
      color: map['color'] as String,
      icon: map['icon'] as int,
      todos: map['todos'] as List<dynamic>,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  @override
  List<Object?> get props => [title, icon, color];

  bool isTodosEmpty() {
    return todos == null || todos?.isEmpty == true;
  }

  int numTodosDone() {
    if (todos == null) return 0;
    return todos!.where((element) => element["done"] == true).length;
  }

  int numTodos() {
    if (todos == null) return 0;
    return todos!.length;
  }

  Color getColor() {
    return HexColor.fromHex(color);
  }

//</editor-fold>
}
