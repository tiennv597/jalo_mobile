import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shinro_int2/network/api_service.dart';
import 'package:shinro_int2/models/grammar/example_model.dart';
import 'package:flutter/cupertino.dart';

import 'example_detail_screen.dart';

class ExamplePage extends StatefulWidget {
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final SearchBarController<Example> _searchBarController =
      SearchBarController();
  bool isReplay = false;

  Future<List<Example>> _getExample(String text) async {
    //await Future.delayed(Duration(seconds: text.length == 4 ? 10 : 1));
    await Future.delayed(Duration(seconds: 0));
    final api = Provider.of<ApiService>(context, listen: false);
    api.getExample(text).then((it) {
      it.forEach((f) {
        print("test" + f.sId);
      });
    }).catchError((onError) {
      print("error" + onError.toString());
    });

    return api.getExample(text);
  }

  _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Listener(
      onPointerUp: (e) {
        _dismissKeyboard(context);
      },
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   leading: IconButton(
        //     icon: Icon(Icons.arrow_back, color: Colors.black),
        //     onPressed: () => Navigator.of(context).pop(),
        //   ),
        //   title: Text("Sample", style: TextStyle(color: Colors.black)),
        // ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: SafeArea(
            child: SearchBar<Example>(
              searchBarPadding: EdgeInsets.symmetric(horizontal: 0),
              headerPadding: EdgeInsets.symmetric(horizontal: 0),
              // listPadding: EdgeInsets.symmetric(horizontal: 8),
              hintText: "Tìm kiếm (Mẫu câu theo ngữ pháp)",
              onSearch: _getExample,
              searchBarController: _searchBarController,
              minimumChars: 1, //Minimum number of chars to start querying
              placeHolder: Text("Chưa tìm kiếm"),
              cancellationWidget: Text("Hủy"),
              emptyWidget: Text("Không tìm thấy mẫu câu phù hợp"),
              header: Row(
                children: <Widget>[
                  // RaisedButton(
                  //   child: Text("Desort"),
                  //   onPressed: () {
                  //     _searchBarController.removeSort();
                  //   },
                  // ),
                  // RaisedButton(
                  //   child: Text("Replay"),
                  //   onPressed: () {
                  //     isReplay = !isReplay;
                  //     _searchBarController.replayLastSearch();
                  //   },
                  // ),
                ],
              ),
              onCancelled: () {
                print("Cancelled triggered");
              },
              onItemFound: (Example example, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailPage(example: example)));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 4.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 30.0,
                          height: 30.0,
                          decoration: new BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                              child: Text(
                            (index + 1).toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.82,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  example.vi,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.82,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(example.sentence,
                                    textAlign: TextAlign.justify),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
