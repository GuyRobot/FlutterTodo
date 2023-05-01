// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      title: json['title'] as String,
      color: json['color'] as String,
      icon: json['icon'] as int,
      todos: json['todos'] as List<dynamic>?,
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'title': instance.title,
      'color': instance.color,
      'icon': instance.icon,
      'todos': instance.todos,
    };
