// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question(
    sId: json['_id'] as String,
    content: json['content'] as String,
    answers: (json['answers'] as List)
        ?.map((e) =>
            e == null ? null : Answers.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      '_id': instance.sId,
      'content': instance.content,
      'answers': instance.answers,
    };
