import 'package:json_annotation/json_annotation.dart';
import 'answers_model.dart';
part 'question_model.g.dart';

@JsonSerializable()
class Question {
  String sId;
  String content;
  List<Answers> answers;

  Question({this.sId, this.content, this.answers});

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
