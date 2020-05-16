import 'package:json_annotation/json_annotation.dart';

import 'grammar_model.dart';

part 'example_model.g.dart';


@JsonSerializable()
class Example {

  String sId;
  String exampleId;
  String sentence;
  String vi;
  String furigana;
  List<Grammar> grammar;

  Example(
      {this.sId,
      this.exampleId,
      this.sentence,
      this.vi,
      this.furigana,
      this.grammar});

  factory Example.fromJson(Map<String, dynamic> json)=>_$ExampleFromJson(json);

  Map<String, dynamic> toJson() =>_$ExampleToJson(this);
}


