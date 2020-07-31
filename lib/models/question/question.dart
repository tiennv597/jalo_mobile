import 'package:json_annotation/json_annotation.dart';
import 'answers_model.dart';

@JsonSerializable()
class Question {
  final String sId;
  final String content;
  final List<Answers> answers;
  final List<String> underline;
  Question({this.sId, this.content, this.answers, this.underline});
}

final questionList = [
  Question(sId: "id1", content: "先生に貴重な資料を見せていただいた。", answers: [
    Answers(answer: "きじゅう", result: true),
    Answers(answer: "きちょう", result: false),
    Answers(answer: "きっじゅう", result: false),
    Answers(answer: "きっちょう", result: false),
  ], underline: [
    "貴重"
  ]),
  Question(sId: "id2", content: "その話を聞いて、とても怪しいと思った。", answers: [
    Answers(answer: "むなしい", result: false),
    Answers(answer: "くやしい", result: false),
    Answers(answer: "おかしい", result: true),
    Answers(answer: "あやしい", result: false)
  ], underline: [
    "怪しい"
  ]),
  Question(sId: "id3", content: "佐藤さんは容姿も性格もいい。", answers: [
    Answers(answer: "よし", result: false),
    Answers(answer: "ようし", result: false),
    Answers(answer: "ようす", result: true),
    Answers(answer: "よす", result: false)
  ], underline: [
    "容姿"
  ]),
  Question(sId: "id4", content: "これは危険を伴う実験だ。", answers: [
    Answers(answer: "はらう", result: false),
    Answers(answer: "あつかう", result: false),
    Answers(answer: "ともなう", result: true),
    Answers(answer: "すくう", result: false)
  ], underline: [
    "伴う"
  ]),
  Question(sId: "id5", content: "以前は、海外で暮らしたいという願望が強かった。", answers: [
    Answers(answer: "がんぼう", result: false),
    Answers(answer: "げんぼう", result: false),
    Answers(answer: "がんぼ", result: true),
    Answers(answer: "げんぼ", result: false)
  ], underline: [
    "願望"
  ]),
  Question(sId: "id6", content: "友人を家にまねいた。", answers: [
    Answers(answer: "伯いた", result: false),
    Answers(answer: "招いた", result: false),
    Answers(answer: "泊いた", result: true),
    Answers(answer: "召いた", result: false)
  ], underline: [
    "まねいた"
  ]),
  Question(sId: "id7", content: "この商品は安全性がほしょうされている。", answers: [
    Answers(answer: "補証", result: false),
    Answers(answer: "保正", result: false),
    Answers(answer: "保証", result: true),
    Answers(answer: "補正", result: false)
  ], underline: [
    "ほしょう"
  ]),
  Question(sId: "id8", content: "この企業では、さまざまなもよおしを行っている。", answers: [
    Answers(answer: "携し", result: false),
    Answers(answer: "催し", result: false),
    Answers(answer: "推し", result: true),
    Answers(answer: "権し", result: false)
  ], underline: [
    "もよおし"
  ]),
  Question(sId: "id9", content: "銀行に行って、お札をこうかに替えた。", answers: [
    Answers(answer: "硬貨", result: false),
    Answers(answer: "固貨", result: false),
    Answers(answer: "硬価", result: true),
    Answers(answer: "固価", result: false)
  ], underline: [
    "こうか"
  ]),
  Question(sId: "id10", content: "わが社の商品はここでせいぞうされている", answers: [
    Answers(answer: "製増", result: false),
    Answers(answer: "制増", result: false),
    Answers(answer: "制造", result: true),
    Answers(answer: "製造", result: false)
  ], underline: [
    "せいぞう"
  ]),
];
