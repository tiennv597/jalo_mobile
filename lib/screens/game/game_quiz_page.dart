import 'dart:async';
import 'dart:convert';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shinro_int2/models/category.dart';
import 'package:shinro_int2/models/question/answers_model.dart';
import 'package:shinro_int2/models/question/question_model.dart';
import 'package:shinro_int2/screens/game/components/user_rank_item.dart';
import 'package:shinro_int2/screens/game/game_result_page.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:shinro_int2/constant/socket_constant.dart' as SOCKET_CONSTANT;

class GameQuizPage extends StatefulWidget {
  var mydata;
  Socket socket;

  GameQuizPage({this.socket, this.mydata});

  @override
  GameQuizPageState createState() {
    return new GameQuizPageState();
  }
}

class GameQuizPageState extends State<GameQuizPage> {
  var mydata;
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
  int timer = 30;
  String showtimer = "30";
  var random_array;
  List<Question> questions = new List<Question>();
  List random = new List();
  Question question;
  //data test
  List<Category> categories = [
    Category(
      Color(0xffFCE183),
      Color(0xffF68D7F),
      'Gadgets',
      'assets/jeans_5.png',
    ),
    Category(
      Color(0xffF749A2),
      Color(0xffFF7375),
      'Clothes',
      'assets/jeans_5.png',
    ),
    Category(
      Color(0xff00E9DA),
      Color(0xff5189EA),
      'Fashion',
      'assets/jeans_5.png',
    ),
    Category(
      Color(0xffAF2D68),
      Color(0xff632376),
      'Home',
      'assets/jeans_5.png',
    ),
    Category(
      Color(0xff36E892),
      Color(0xff33B2B9),
      'Beauty',
      'assets/jeans_5.png',
    ),
    Category(
      Color(0xffF123C4),
      Color(0xff668CEA),
      'Appliances',
      'assets/jeans_5.png',
    ),
  ];

  Map<String, Color> btncolor = {
    "a": Colors.indigoAccent,
    "b": Colors.indigoAccent,
    "c": Colors.indigoAccent,
    "d": Colors.indigoAccent,
  };

  bool canceltimer = false;

  // code inserted for choosing questions randomly
  // to create the array elements randomly use the dart:math module
  // -----     CODE TO GENERATE ARRAY RANDOMLY

  genrandomarray() {
    var distinctIds = [];
    var rand = new Random();
    for (int i = 0;;) {
      distinctIds.add(rand.nextInt(10));
      random_array = distinctIds.toSet().toList();
      if (random_array.length < 10) {
        continue;
      } else {
        break;
      }
    }
    print(random_array);
  }

  // overriding the initstate function to start timer as this screen is created
  @override
  void initState() {
    random = shuffle([0, 1, 2, 3]);
    widget.socket.emit(SOCKET_CONSTANT.start_game, {"tttt", "n5", "goi"});
    widget.socket.on(SOCKET_CONSTANT.start_game, (data) {
      // Parsing JSON to Jobject
      //final List parsedList = json.decode(data);
      //Question questions = Question.fromJson(json.decode(data));
      //List<Question> listQuestion = parsedList.map((val) =>  Question.fromJson(val)).toList();
      var list = data
          .map((dynamic i) => Question.fromJson(i as Map<String, dynamic>))
          .toList();
      for (var item in list) {
        Question question = new Question();
        question = item;
        questions.add(question);
      }
    });

    starttimer();
    genrandomarray();

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
      if (j < 10) {
        i = random_array[j];
        j++;
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => resultpage(marks: marks),
        ));
      }
      btncolor["a"] = Colors.indigoAccent;
      btncolor["b"] = Colors.indigoAccent;
      btncolor["c"] = Colors.indigoAccent;
      btncolor["d"] = Colors.indigoAccent;
    });
    starttimer();
  }

  void checkanswer(String k) {
    // in the previous version this was
    // mydata[2]["1"] == mydata[1]["1"][k]
    // which i forgot to change
    // so nake sure that this is now corrected
    if (widget.mydata[2][i.toString()] == widget.mydata[1][i.toString()][k]) {
      // just a print sattement to check the correct working
      // debugPrint(mydata[2][i.toString()] + " is equal to " + mydata[1][i.toString()][k]);
      marks = marks + 5;
      // changing the color variable to be green
      colortoshow = right;
    } else {
      // just a print sattement to check the correct working
      // debugPrint(mydata[2]["1"] + " is equal to " + mydata[1]["1"][k]);
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

  Widget choiceButton(int k) {
    //Answers answers = new Answers();
    //answers = questions[current].answers[k];
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 8.0,
      ),
      child: MaterialButton(
        //onPressed: () => checkanswer(k),
        onPressed: () => {},
        child: Text(
          //answers.answer,
          "dddd",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Alike",
            fontSize: 16.0,
          ),
          maxLines: 1,
        ),
        color: Colors.blue,
        splashColor: Colors.indigo[700],
        highlightColor: Colors.indigo[700],
        minWidth: 400.0,
        height: 64.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
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
          List<Question> questions1 = new List<Question>();
          questions1=snapshot.data;
          print(questions1);
        if(!snapshot.hasData){
          return Text("loading");
        }
        else{
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
                    height: 80,
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
                          questions1[current].content.toString(),
                          //"ddddddddd",
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
                      choiceButton(random[0]),
                      choiceButton(random[1]),
                      choiceButton(random[2]),
                      choiceButton(random[3]),
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
