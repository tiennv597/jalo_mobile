import 'package:json_annotation/json_annotation.dart';
part 'answers_model.g.dart';

@JsonSerializable()
class Answers {
  String answer;
  bool result;

  Answers({this.answer, this.result});

  factory Answers.fromJson(Map<String, dynamic> json) => _$AnswersFromJson(json);

  Map<String, dynamic> toJson() => _$AnswersToJson(this);
}
