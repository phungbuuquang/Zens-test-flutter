import 'package:json_annotation/json_annotation.dart';

part 'joke_model.g.dart';

@JsonSerializable()
class JokeModel {
  int? id;
  String? content;
  int? is_fun;

  JokeModel({
    this.content,
    this.is_fun,
  });

  factory JokeModel.fromJson(Map<String, dynamic> json) =>
      _$JokeModelFromJson(json);

  Map<String, dynamic> toJson() => _$JokeModelToJson(this);
}
