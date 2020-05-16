// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grammar_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Grammar _$GrammarFromJson(Map<String, dynamic> json) {
  return Grammar(
    grammarId: json['grammar_id'] as String,
    level: json['level'] as String,
    content: json['content'] as String,
    mean: json['mean'] as String,
    use: json['use'] as String,
    note: json['note'] as String,
  );
}

Map<String, dynamic> _$GrammarToJson(Grammar instance) => <String, dynamic>{
      'grammarId': instance.grammarId,
      'level': instance.level,
      'content': instance.content,
      'mean': instance.mean,
      'use': instance.use,
      'note': instance.note,
    };
