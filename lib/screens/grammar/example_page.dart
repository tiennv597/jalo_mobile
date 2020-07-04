import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shinro_int2/network/api_service.dart';
import 'package:shinro_int2/models/grammar/example_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shinro_int2/screens/grammar/example_detail_page.dart';

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
        body: Padding(
          padding: const EdgeInsets.only(left: 8,right: 8),
          child: SafeArea(
            child: SearchBar<Example>(
              searchBarPadding: EdgeInsets.symmetric(horizontal: 0),
              headerPadding: EdgeInsets.symmetric(horizontal: 0),
              // listPadding: EdgeInsets.symmetric(horizontal: 8),
              onSearch: _getExample,
              searchBarController: _searchBarController,
              minimumChars: 1, //Minimum number of chars to start querying
              placeHolder: Text("placeholder"),
              cancellationWidget: Text("cancel"),
              emptyWidget: Text("empty"),              
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
                return ListTile(
                  title: Text(example.sId),
                  isThreeLine: true,
                  subtitle: Text(example.sentence),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailPage(example: example)));
                  },
                  
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}


