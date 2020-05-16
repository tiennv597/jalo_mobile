import 'package:json_annotation/json_annotation.dart';
part 'grammar_model.g.dart';

@JsonSerializable()
class Grammar {
  String grammarId;
  String level;
  String content;
  String mean;
  String use;
  String note;

  Grammar(
      {this.grammarId,
        this.level,
        this.content,
        this.mean,
        this.use,
        this.note});

  factory Grammar.fromJson(Map<String, dynamic> json) =>_$GrammarFromJson(json);

  Map<String, dynamic> toJson()  =>_$GrammarToJson(this);
}
