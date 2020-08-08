class Questions {
  List<Question> questions;

  Questions({this.questions});

  Questions.fromJson(Map<String, dynamic> json) {
    if (json['questions'] != null) {
      questions = new List<Question>();
      json['questions'].forEach((v) {
        questions.add(new Question.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questions != null) {
      data['questions'] = this.questions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Question {
  String sId;
  List<String> bold;
  List<String> italic;
  List<String> underline;
  Level level;
  Type type;
  SubType subType;
  String question;
  String explain;
  List<Answer> answer;
  String date;
  List<Comments> comments;
  String idQuestion;
  int iV;

  Question(
      {this.sId,
      this.bold,
      this.italic,
      this.underline,
      this.level,
      this.type,
      this.subType,
      this.question,
      this.explain,
      this.answer,
      this.date,
      this.comments,
      this.idQuestion,
      this.iV});

  Question.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    bold = json['bold'].cast<String>();
    italic = json['italic'].cast<String>();
    underline = json['underline'].cast<String>();
    level = json['level'] != null ? new Level.fromJson(json['level']) : null;
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
    subType =
        json['subType'] != null ? new SubType.fromJson(json['subType']) : null;
    question = json['question'];
    explain = json['explain'];
    if (json['answer'] != null) {
      answer = new List<Answer>();
      json['answer'].forEach((v) {
        answer.add(new Answer.fromJson(v));
      });
    }
    date = json['date'];
    if (json['comments'] != null) {
      comments = new List<Comments>();
      json['comments'].forEach((v) {
        comments.add(new Comments.fromJson(v));
      });
    }
    idQuestion = json['idQuestion'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['bold'] = this.bold;
    data['italic'] = this.italic;
    data['underline'] = this.underline;
    if (this.level != null) {
      data['level'] = this.level.toJson();
    }
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    if (this.subType != null) {
      data['subType'] = this.subType.toJson();
    }
    data['question'] = this.question;
    data['explain'] = this.explain;
    if (this.answer != null) {
      data['answer'] = this.answer.map((v) => v.toJson()).toList();
    }
    data['date'] = this.date;
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    data['idQuestion'] = this.idQuestion;
    data['__v'] = this.iV;
    return data;
  }
}

class Level {
  String id;
  String name;

  Level({this.id, this.name});

  Level.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Type {
  String id;
  String name;

  Type({this.id, this.name});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class SubType {
  String id;
  String name;

  SubType({this.id, this.name});

  SubType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Answer {
  String answer;
  bool result;

  Answer({this.answer, this.result});

  Answer.fromJson(Map<String, dynamic> json) {
    answer = json['answer'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer'] = this.answer;
    data['result'] = this.result;
    return data;
  }
}

class Comments {
  String author;
  String imageURL;
  String body;
  String date;

  Comments({this.author, this.imageURL, this.body, this.date});

  Comments.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    imageURL = json['imageURL'];
    body = json['body'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['imageURL'] = this.imageURL;
    data['body'] = this.body;
    data['date'] = this.date;
    return data;
  }
}

// import 'package:json_annotation/json_annotation.dart';
// import 'answers_model.dart';

// @JsonSerializable()
// class Question {
//   final String sId;
//   final String content;
//   final List<Answers> answers;
//   final List<String> underline;
//   Question({this.sId, this.content, this.answers, this.underline});
// }

// final questionList = [
//   Question(sId: "id1", content: "先生に貴重な資料を見せていただいた。", answers: [
//     Answers(answer: "きじゅう", result: true),
//     Answers(answer: "きちょう", result: false),
//     Answers(answer: "きっじゅう", result: false),
//     Answers(answer: "きっちょう", result: false),
//   ], underline: [
//     "貴重"
//   ]),
//   Question(sId: "id2", content: "その話を聞いて、とても怪しいと思った。", answers: [
//     Answers(answer: "むなしい", result: false),
//     Answers(answer: "くやしい", result: false),
//     Answers(answer: "おかしい", result: true),
//     Answers(answer: "あやしい", result: false)
//   ], underline: [
//     "怪しい"
//   ]),
//   Question(sId: "id3", content: "佐藤さんは容姿も性格もいい。", answers: [
//     Answers(answer: "よし", result: false),
//     Answers(answer: "ようし", result: false),
//     Answers(answer: "ようす", result: true),
//     Answers(answer: "よす", result: false)
//   ], underline: [
//     "容姿"
//   ]),
//   Question(sId: "id4", content: "これは危険を伴う実験だ。", answers: [
//     Answers(answer: "はらう", result: false),
//     Answers(answer: "あつかう", result: false),
//     Answers(answer: "ともなう", result: true),
//     Answers(answer: "すくう", result: false)
//   ], underline: [
//     "伴う"
//   ]),
//   Question(sId: "id5", content: "以前は、海外で暮らしたいという願望が強かった。", answers: [
//     Answers(answer: "がんぼう", result: false),
//     Answers(answer: "げんぼう", result: false),
//     Answers(answer: "がんぼ", result: true),
//     Answers(answer: "げんぼ", result: false)
//   ], underline: [
//     "願望"
//   ]),
//   Question(sId: "id6", content: "友人を家にまねいた。", answers: [
//     Answers(answer: "伯いた", result: false),
//     Answers(answer: "招いた", result: false),
//     Answers(answer: "泊いた", result: true),
//     Answers(answer: "召いた", result: false)
//   ], underline: [
//     "まねいた"
//   ]),
//   Question(sId: "id7", content: "この商品は安全性がほしょうされている。", answers: [
//     Answers(answer: "補証", result: false),
//     Answers(answer: "保正", result: false),
//     Answers(answer: "保証", result: true),
//     Answers(answer: "補正", result: false)
//   ], underline: [
//     "ほしょう"
//   ]),
//   Question(sId: "id8", content: "この企業では、さまざまなもよおしを行っている。", answers: [
//     Answers(answer: "携し", result: false),
//     Answers(answer: "催し", result: false),
//     Answers(answer: "推し", result: true),
//     Answers(answer: "権し", result: false)
//   ], underline: [
//     "もよおし"
//   ]),
//   Question(sId: "id9", content: "銀行に行って、お札をこうかに替えた。", answers: [
//     Answers(answer: "硬貨", result: false),
//     Answers(answer: "固貨", result: false),
//     Answers(answer: "硬価", result: true),
//     Answers(answer: "固価", result: false)
//   ], underline: [
//     "こうか"
//   ]),
//   Question(sId: "id10", content: "わが社の商品はここでせいぞうされている", answers: [
//     Answers(answer: "製増", result: false),
//     Answers(answer: "制増", result: false),
//     Answers(answer: "制造", result: true),
//     Answers(answer: "製造", result: false)
//   ], underline: [
//     "せいぞう"
//   ]),
// ];
