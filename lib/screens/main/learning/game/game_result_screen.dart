import 'package:flutter/material.dart';
import 'package:shinro_int2/constant/app_colors.dart' as COLORS;

class ResultPage extends StatefulWidget {
  final marks;
  final sortedKeys;
  final Map<String, dynamic> statusAll;
  ResultPage({Key key, @required this.sortedKeys, this.statusAll, this.marks})
      : super(key: key);
  @override
  _ResultPageState createState() =>
      _ResultPageState(sortedKeys, statusAll, marks);
}

class _ResultPageState extends State<ResultPage> {
  List<String> images = [
    "assets/success.png",
    "assets/good.png",
    "assets/bad.png",
  ];

  String message;
  String image;

  @override
  void initState() {
    if (marks < 20) {
      image = images[2];
      message = "You Should Try Hard..\n" + "You Scored $marks";
    } else if (marks < 35) {
      image = images[1];
      message = "You Can Do Better..\n" + "You Scored $marks";
    } else {
      image = images[0];
      message = "You Did Very Well..\n" + "You Scored $marks";
    }
    super.initState();
  }

  var marks;
  var sortedKeys;
  final Map<String, dynamic> statusAll;
  _ResultPageState(this.sortedKeys, this.statusAll, this.marks);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Result",
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Material(
              elevation: 10.0,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      child: Container(
                        width: 200.0,
                        height: 200.0,
                        child: ClipRect(
                          child: Image(
                            image: AssetImage(
                              image,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 15.0,
                        ),
                        child: Center(
                          child: Text(
                            message,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "Quando",
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 25.0,
                  ),
                  borderSide: BorderSide(width: 3.0, color: Colors.indigo),
                  splashColor: Colors.indigoAccent,
                )
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: ListView.builder(
              itemBuilder: (context, int index) => GestureDetector(
                onTap: () {
                  print("object");
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Card(
                    child: ClipRRect(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: COLORS.colorBlue2),
                              child: CircleAvatar(
                                child: new Text((index + 1).toString()),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(statusAll[
                                    sortedKeys[statusAll.length - 1 - index]]
                                .userName),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(statusAll[
                                    sortedKeys[statusAll.length - 1 - index]]
                                .marks
                                .toString()),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              itemCount: statusAll.length,
            ),
          )
        ],
      ),
    );
  }
}
