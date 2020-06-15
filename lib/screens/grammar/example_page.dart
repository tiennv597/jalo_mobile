import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shinro_int2/network/api_service.dart';
import 'package:shinro_int2/models/grammar/example_model.dart';
import 'package:shinro_int2/constant/app_properties.dart';
import 'package:flutter/cupertino.dart';

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
          padding: const EdgeInsets.all(8.0),
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
                  RaisedButton(
                    child: Text("Desort"),
                    onPressed: () {
                      _searchBarController.removeSort();
                    },
                  ),
                  RaisedButton(
                    child: Text("Replay"),
                    onPressed: () {
                      isReplay = !isReplay;
                      _searchBarController.replayLastSearch();
                    },
                  ),
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

class DetailPage extends StatefulWidget {
  final Example example;

  // In the constructor, require a Example.
  const DetailPage({Key key, @required this.example}) : super(key: key);

  @override
  State createState() {
    return _DetailPageState();
  }
}

class _DetailPageState extends State<DetailPage> {
  List<Panel> panels = [];
  List<PanelGrammar> panelsGrammar = [];
  @override
  void initState() {
    panels.add(
      Panel(
          'Phiên âm',
          'By default, the last used shipping address will be saved intoto your Sample Store account. When you are checkingout your order, the default shipping address will be displayedand you have the option to amend it if you need to.',
          false),
    );
    panels.add(
      Panel(
          'Gợi ý',
          'By default, the last used shipping address will be saved intoto your Sample Store account. When you are checkingout your order, the default shipping address will be displayedand you have the option to amend it if you need to.',
          false),
    );
    panels.add(
      Panel(
          'Đáp án',
          'By default, the last used shipping address will be saved intoto your Sample Store account. When you are checkingout your order, the default shipping address will be displayedand you have the option to amend it if you need to.',
          false),
    );
    panelsGrammar.add(
      PanelGrammar(
          'Ngữ pháp',
          'Đáp án',
          'By default, the last used shipping address will be saved intoto your Sample Store account. When you are checkingout your order, the default shipping address will be displayedand you have the option to amend it if you need to.',
          'Đáp án',
          'Đáp án',
          'Đáp án',
          'Đáp án',
          false),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        title: Text(
          'Example',
          style: TextStyle(color: darkGrey),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 24.0, right: 24.0, bottom: 16.0),
                child: Text(
                  widget.example.vi,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ),
              ...panels
                  .map((panel) => ExpansionTile(
                          title: Text(
                            panel.title,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ),
                          children: [
                            Container(
                                padding: EdgeInsets.all(16.0),
                                color: Color(0xffFAF1E2),
                                child: Text(panel.content,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12)))
                          ]))
                  .toList(),
              ...panelsGrammar
                  .map((panel) => ExpansionTile(
                          title: Text(
                            panel.title,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ),
                          children: [
                            Container(
                                padding: EdgeInsets.all(16.0),
                                color: Color(0xffFAF1E2),
                                child: Text(panel.content,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12)))
                          ]))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}

class Panel {
  String title;
  String content;
  bool expanded;

  Panel(this.title, this.content, this.expanded);
}

class PanelGrammar {
  String title;
  String grammarId;
  String level;
  String content;
  String mean;
  String use;
  String note;
  bool expanded;
  PanelGrammar(this.title, this.grammarId, this.level, this.content, this.mean,
      this.use, this.note, this.expanded);
}
