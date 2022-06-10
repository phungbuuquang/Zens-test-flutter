// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joke_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JokeModel _$JokeModelFromJson(Map<String, dynamic> json) => JokeModel(
      content: json['content'] as String?,
      is_fun: json['is_fun'] as int?,
    )..id = json['id'] as int?;

Map<String, dynamic> _$JokeModelToJson(JokeModel instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'is_fun': instance.is_fun,
    };
