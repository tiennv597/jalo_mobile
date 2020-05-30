// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answers_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Answers _$AnswersFromJson(Map<String, dynamic> json) {
  return Answers(
    answer: json['answer'] as String,
    result: json['result'] as bool,
  );
}

Map<String, dynamic> _$AnswersToJson(Answers instance) => <String, dynamic>{
      'answer': instance.answer,
      'result': instance.result,
    };
