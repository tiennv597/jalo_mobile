import 'package:json_annotation/json_annotation.dart';
import 'answers_model.dart';
part 'question_model.g.dart';

@JsonSerializable()
class Question {
  final String sId;
  final String content;
  final List<Answers> answers;

  Question({this.sId, this.content, this.answers});

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

final questionList = [
  Question(sId: "id1", content: "cau hoi 1", answers: [
    Answers(answer: "dap an 1", result: true),
    Answers(answer: "dap an 2", result: false),
    Answers(answer: "dap an 3", result: false),
    Answers(answer: "dap an 4", result: false)
  ]),
  Question(sId: "id2", content: "cau hoi 2", answers: [
    Answers(answer: "dap an 1", result: false),
    Answers(answer: "dap an 2", result: false),
    Answers(answer: "dap an 3", result: true),
    Answers(answer: "dap an 4", result: false)
  ]),
  Question(sId: "id2", content: "cau hoi 2", answers: [
    Answers(answer: "dap an 1", result: false),
    Answers(answer: "dap an 2", result: false),
    Answers(answer: "dap an 3", result: true),
    Answers(answer: "dap an 4", result: false)
  ]),
  Question(sId: "id2", content: "cau hoi 2", answers: [
    Answers(answer: "dap an 1", result: false),
    Answers(answer: "dap an 2", result: false),
    Answers(answer: "dap an 3", result: true),
    Answers(answer: "dap an 4", result: false)
  ]),
  Question(sId: "id2", content: "cau hoi 2", answers: [
    Answers(answer: "dap an 1", result: false),
    Answers(answer: "dap an 2", result: false),
    Answers(answer: "dap an 3", result: true),
    Answers(answer: "dap an 4", result: false)
  ]),
  Question(sId: "id2", content: "cau hoi 2", answers: [
    Answers(answer: "dap an 1", result: false),
    Answers(answer: "dap an 2", result: false),
    Answers(answer: "dap an 3", result: true),
    Answers(answer: "dap an 4", result: false)
  ]),
  Question(sId: "id2", content: "cau hoi 2", answers: [
    Answers(answer: "dap an 1", result: false),
    Answers(answer: "dap an 2", result: false),
    Answers(answer: "dap an 3", result: true),
    Answers(answer: "dap an 4", result: false)
  ]),
  Question(sId: "id2", content: "cau hoi 2", answers: [
    Answers(answer: "dap an 1", result: false),
    Answers(answer: "dap an 2", result: false),
    Answers(answer: "dap an 3", result: true),
    Answers(answer: "dap an 4", result: false)
  ]),
  Question(sId: "id2", content: "cau hoi 2", answers: [
    Answers(answer: "dap an 1", result: false),
    Answers(answer: "dap an 2", result: false),
    Answers(answer: "dap an 3", result: true),
    Answers(answer: "dap an 4", result: false)
  ]),
  Question(sId: "id2", content: "cau hoi 2", answers: [
    Answers(answer: "dap an 1", result: false),
    Answers(answer: "dap an 2", result: false),
    Answers(answer: "dap an 3", result: true),
    Answers(answer: "dap an 4", result: false)
  ]),
];
