import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shinro_int2/models/game/info_room.dart';
import 'package:shinro_int2/models/game/info_user.dart';
import 'package:shinro_int2/models/question/questions.dart';
import 'package:shinro_int2/widgets/widgets.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:shinro_int2/constant/network_constant.dart' as NETWORK_CONSTANT;
import 'package:quiver/async.dart';
import 'components/user_rank_item.dart';
import 'game_result_screen.dart';

class GameQuizPage extends StatefulWidget {
  //var mydata;
  final Socket socket;
  final String idRoom;
  final bool owner;
  final InfoRoom infoRoom;
  final List<User> users;
  final Questions questionList;
  final int userInRoom;
  GameQuizPage(
      {this.socket,
      this.idRoom,
      this.owner,
      this.infoRoom,
      this.users,
      this.questionList,
      this.userInRoom});

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
  int timer;
  int selectedQuantity = 0;
  String showtimer;
  CountdownTimer countDownTimer;
  List random;
  int actual;
  var countdown;
  Map<String, Color> btncolor = {
    "a": Colors.indigoAccent,
    "b": Colors.indigoAccent,
    "c": Colors.indigoAccent,
    "d": Colors.indigoAccent,
  };
// Creating a new timer element.

  bool canceltimer = false;

  // overriding the initstate function to start timer as this screen is created
  @override
  void initState() {
    random = new List();
    random = shuffle([0, 1, 2, 3]);
    //starttimer();
    startTimer();
    widget.socket.on(NETWORK_CONSTANT.check_answer, (data) {
      selectedQuantity++;
      if (selectedQuantity == widget.userInRoom) {
        widget.socket.emit(NETWORK_CONSTANT.next_question, {widget.idRoom});
        selectedQuantity = 0;
      }
      print(data.toString());
    });
    widget.socket.on(NETWORK_CONSTANT.next_question, (_) {
      setState(() {
        // canceltimer = true;
        //starttimer();
        restartTimer();
      });
      Timer(Duration(seconds: 1), nextquestion);
    });

    super.initState();
  }

  void restartTimer() {
    countDownTimer.cancel();
    startTimer();
  }

  // overriding the setstate function to be called only if mounted
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    super.dispose();
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

  // void starttimer() async {
  //   timer = int.parse(widget.infoRoom.info.time);
  //   const onesec = Duration(seconds: 1);
  //   Timer.periodic(onesec, (Timer t) {
  //     setState(() {
  //       if (timer < 1) {
  //         //checkAnswer("", false);
  //         // timer = int.parse(widget.infoRoom.info.time);
  //         t.cancel();
  //         checkQuestion();
  //       } else if (canceltimer == true) {
  //         t.cancel();
  //       } else {
  //         timer = timer - 1;
  //       }
  //       showtimer = timer.toString();
  //     });

  //     // setState(() {
  //     //   if (timer < 1) {
  //     //     checkQuestion();
  //     //     t.cancel();
  //     //     // nextquestion();
  //     //   } else if (canceltimer == true) {
  //     //     // t.cancel();
  //     //   } else {
  //     //
  //     //   }
  //     //   showtimer = timer.toString();
  //     // });
  //   });
  // }

  void startTimer() {
    countDownTimer = new CountdownTimer(
      new Duration(minutes: 5),
      new Duration(seconds: 1),
    );

    countdown = countDownTimer.listen(null);
    countdown.onData((duration) {
      setState(() {
        actual = 10 - duration.elapsed.inSeconds;
        if (actual < 1) {
          checkQuestion();
        }
      });
    });

    countdown.onDone(() {
      countdown.cancel();
    });
  }

  void checkQuestion() {
    // send status marks to server
    widget.socket.emit(NETWORK_CONSTANT.check_answer, {
      widget.idRoom,
      widget.infoRoom.users.id,
      widget.infoRoom.users.fullName,
      marks
    });
    // selectedQuantity++;
  }

  void nextquestion() {
    // checkQuestion();
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
  }

  void checkAnswer(String k, bool result) {
    // check seleced answer quantity
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
      //canceltimer = true;
    });
    checkQuestion();
    //
    // if (selectedQuantity == widget.userInRoom) {
    //   widget.socket.emit(NETWORK_CONSTANT.next_question, {widget.idRoom});
    //   setState(() {
    //     // applying the changed color to the particular button that was selected
    //     selectedQuantity = 0;
    //     //canceltimer = true;
    //   });
    // }
    // changed timer duration to 1 second
    //Timer(Duration(seconds: 1), nextquestion);
    // nextquestion();
  }

  Widget choiceButton(String k, Answer answers) {
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
          height: screenHeight / 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    );
  }

  Future<Questions> getFutureQuestion() async =>
      await Future.delayed(Duration(seconds: 1), () {
        if (widget.questionList.questions != null) {
          totalQuestion = widget.questionList.questions.length - 1;
        }
        return (widget.questionList);
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
          if (!snapshot.hasData) {
            timer = int.parse(widget.infoRoom.info.time);
            showtimer = widget.infoRoom.info.time;
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: CircularProgressIndicator(),
              ),
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
                      height: screenHeight / 8,
                      width: screenWidth / 2,
                      // list message
                      child: ListView.builder(
                        //reverse: true,
                        itemBuilder: (context, int index) => UserRankItem(
                          user: widget.users[index],
                        ),
                        itemCount: widget.users.length,
                      ),
                    ),
                  ),
                  Positioned(
                      top: 88,
                      left: 10,
                      child: Text("Câu hỏi: " +
                          (current + 1).toString() +
                          "/" +
                          (totalQuestion + 1).toString())),
                  Positioned(
                      top: 88,
                      right: 12,
                      child: Text("Score:" + marks.toString())),
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
                          child: TextUnderline(
                              text: snapshot.data.questions[current].question
                                  .toString(),
                              underline:
                                  snapshot.data.questions[current].underline),
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
                          actual.toString(),
                          style: TextStyle(
                            fontSize: 36.0,
                            fontWeight: FontWeight.w700,
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
                        choiceButton("a",
                            snapshot.data.questions[current].answer[random[0]]),
                        choiceButton("b",
                            snapshot.data.questions[current].answer[random[1]]),
                        choiceButton("c",
                            snapshot.data.questions[current].answer[random[2]]),
                        choiceButton("d",
                            snapshot.data.questions[current].answer[random[3]]),
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
