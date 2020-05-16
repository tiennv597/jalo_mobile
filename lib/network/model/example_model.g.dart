// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Example _$ExampleFromJson(Map<String, dynamic> json) {
  return Example(
    sId: json['sId'] as String,
    exampleId: json['exampleId'] as String,
    sentence: json['sentence'] as String,
    vi: json['vi'] as String,
    furigana: json['furigana'] as String,
    grammar: (json['grammar'] as List)
        ?.map((e) =>
            e == null ? null : Grammar.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ExampleToJson(Example instance) => <String, dynamic>{
      'sId': instance.sId,
      'exampleId': instance.exampleId,
      'sentence': instance.sentence,
      'vi': instance.vi,
      'furigana': instance.furigana,
      'grammar': instance.grammar,
    };
