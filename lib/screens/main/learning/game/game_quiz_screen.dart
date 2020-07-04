import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shinro_int2/models/category.dart';
import 'package:shinro_int2/models/game/info_room.dart';
import 'package:shinro_int2/models/question/answers_model.dart';
import 'package:shinro_int2/models/question/question_model.dart';

import 'package:socket_io_client/socket_io_client.dart';
import 'package:shinro_int2/constant/network_constant.dart' as NETWORK_CONSTANT;

import 'components/user_rank_item.dart';
import 'game_result_screen.dart';

class GameQuizPage extends StatefulWidget {
  //var mydata;
  final Socket socket;
  final String idRoom;
  final bool owner;
  final InfoRoom infoRoom;

  GameQuizPage({this.socket, this.idRoom, this.owner, this.infoRoom});

  @override
  GameQuizPageState createState() {
    return new GameQuizPageState();
  }
}

class GameQuizPageState extends State<GameQuizPage> {
  //var mydata;
  // Socket socket;
  // GameQuizPageState(this.socket,this.mydata);
  Color colortoshow = Colors.indigoAccent;
  Color right = Colors.green;
  Color wrong = Colors.red;
  int marks = 0;
  int i = 1;
  // extra varibale to iterate
  int j = 1;
  int current = 0; //current question
  int totalQuestion = 0; //total of questions
  int timer = 30;
  String showtimer = "30";

  List<Question> questions = new List<Question>();
  List random = new List();
  Question question;
  //data test
  List<Category> categories = [
    Category(
      Color(0xffF749A2),
      Color(0xffFF7375),
      'Clothes',
      'assets/image.jpg',
    ),
    Category(
      Color(0xff00E9DA),
      Color(0xff5189EA),
      'Fashion',
      'assets/image.jpg',
    ),
    Category(
      Color(0xffAF2D68),
      Color(0xff632376),
      'Home',
      'assets/image.jpg',
    )
  ];

  Map<String, Color> btncolor = {
    "a": Colors.indigoAccent,
    "b": Colors.indigoAccent,
    "c": Colors.indigoAccent,
    "d": Colors.indigoAccent,
  };

  bool canceltimer = false;

  // overriding the initstate function to start timer as this screen is created
  @override
  void initState() {
    random = shuffle([0, 1, 2, 3]);
    if (widget.owner) {
      widget.socket.emit(NETWORK_CONSTANT.get_quizzes,
          {widget.idRoom, widget.infoRoom.level, "goi"});
    } else {}

    widget.socket.on(NETWORK_CONSTANT.send_quizzes, (data) {
      // Parsing JSON to Jobject
      var list = data
          .map((dynamic i) => Question.fromJson(i as Map<String, dynamic>))
          .toList();
      for (var item in list) {
        Question question = new Question();
        question = item;
        questions.add(question);
        print(question.content);
      }

      totalQuestion = questions.length - 1;
    });

    starttimer();

    super.initState();
    print(random);
  }

  // overriding the setstate function to be called only if mounted
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

// shuffle list
  List shuffle(List items) {
    var random = new Random();
    // Go through all elements.
    for (var i = items.length - 1; i > 0; i--) {
      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);
      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }
    return items;
  }

  void starttimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          nextquestion();
        } else if (canceltimer == true) {
          t.cancel();
        } else {
          timer = timer - 1;
        }
        showtimer = timer.toString();
      });
    });
  }

  void nextquestion() {
    canceltimer = false;
    timer = 30;
    setState(() {
      if (current < totalQuestion) {
        current++;
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ResultPage(marks: marks),
        ));
      }
      btncolor["a"] = Colors.indigoAccent;
      btncolor["b"] = Colors.indigoAccent;
      btncolor["c"] = Colors.indigoAccent;
      btncolor["d"] = Colors.indigoAccent;
    });
    starttimer();
  }

  void checkAnswer(String k, bool result) {
    // so nake sure that this is now corrected
    if (result) {
      marks = marks + 5;
      // changing the color variable to be green
      colortoshow = right;
    } else {
      // just a print sattement to check the correct working
      colortoshow = wrong;
    }
    setState(() {
      // applying the changed color to the particular button that was selected
      btncolor[k] = colortoshow;
      canceltimer = true;
    });

    // changed timer duration to 1 second
    Timer(Duration(seconds: 1), nextquestion);
  }

  Widget choiceButton(String k, Answers answers) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 8.0,
        ),
        child: MaterialButton(
          onPressed: () => checkAnswer(k, answers.result),
          child: Text(
            answers.answer, //set answer on button
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Alike",
              fontSize: 16.0,
            ),
            maxLines: 1,
          ),
          color: btncolor[k],
          splashColor: Colors.indigo[700],
          highlightColor: Colors.indigo[700],
          height: screenHeight/10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    );
  }

  Future<List<Question>> getFutureQuestion() async =>
      await Future.delayed(Duration(seconds: 1), () {
        return questions;
      });
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    return FutureBuilder(
        future: getFutureQuestion(),
        builder: (context, snapshot) {
          List<Question> questions = new List<Question>();
          questions = snapshot.data;
          print(questions);
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(40.0), // here the desired height
                child: AppBar(
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  brightness: Brightness.light,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              ),
              backgroundColor: Colors.white,
              body: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    child: Container(
                      height: screenHeight/8,
                      width: screenWidth / 2,
                      // list message
                      child: ListView.builder(
                        //reverse: true,
                        itemBuilder: (context, int index) => UserRankItem(
                          category: categories[index],
                        ),
                        itemCount: categories.length,
                      ),
                    ),
                  ),
                  Positioned(top: 88, left: 8, child: Text("Câu hỏi: 1/15")),
                  Positioned(top: 88, right: 8, child: Text("Score:0000")),
                  Positioned(
                    top: 110,
                    left: 8,
                    child: Container(
                      width: screenWidth - 16,
                      height: 160,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Container(
                        child: Center(
                          child: Text(
                            questions[current].content.toString(),
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "Quando",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: screenWidth / 2 - 30,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      child: Center(
                        child: Text(
                          showtimer,
                          style: TextStyle(
                            fontSize: 36.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Times New Roman',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 280,
                    left: -4,
                    child: Column(
                      children: <Widget>[
                        choiceButton(
                            "a", questions[current].answers[random[0]]),
                        choiceButton(
                            "b", questions[current].answers[random[1]]),
                        choiceButton(
                            "c", questions[current].answers[random[2]]),
                        choiceButton(
                            "d", questions[current].answers[random[3]]),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
