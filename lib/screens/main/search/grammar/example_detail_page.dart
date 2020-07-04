import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shinro_int2/models/grammar/example_model.dart';
import 'package:shinro_int2/constant/app_properties.dart';
import 'package:flutter/cupertino.dart';
import 'package:shinro_int2/models/grammar/grammar_model.dart';

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
    List<Grammar> grammars = widget.example.grammar;
    Grammar grammar = grammars[0];
    panels.add(
      Panel('Phiên âm', widget.example.furigana, false),
    );
    panels.add(
      Panel('Gợi ý', grammar.content, false),
    );
    panels.add(
      Panel('Đáp án', widget.example.sentence, false),
    );
    panelsGrammar.add(
      PanelGrammar('Đáp án', grammar.grammarId, grammar.level, grammar.content,
          grammar.mean, grammar.use, grammar.note, false),
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
                                color: Colors.white,
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
                                color: Colors.white,
                                child: Text(panel.level,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12))),
                            Container(
                                padding: EdgeInsets.all(16.0),
                                color: Colors.white,
                                child: Text(panel.content,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12))),
                            Container(
                                padding: EdgeInsets.all(16.0),
                                color: Colors.white,
                                child: Text(panel.mean,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12))),
                            Container(
                                padding: EdgeInsets.all(16.0),
                                color: Colors.white,
                                child: Text(panel.use,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12))),
                            Container(
                                padding: EdgeInsets.all(16.0),
                                color: Colors.white,
                                child: Text(panel.note,
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
