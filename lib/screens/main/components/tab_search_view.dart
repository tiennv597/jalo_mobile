import 'package:shinro_int2/models/category.dart';
import 'package:flutter/material.dart';
import 'package:shinro_int2/models/grammar/example_model.dart';
import 'package:shinro_int2/screens/grammar/example_page.dart';
import 'category_card.dart';
import 'recommended_list.dart';
import 'social_tab.dart';

class TabSearchView extends StatelessWidget {
  final List<Category> categories = [
    Category(
      Color(0xffFCE183),
      Color(0xffF68D7F),
      'Title1',
      'assets/image.jpg',
    ),
    Category(
      Color(0xffF749A2),
      Color(0xffFF7375),
      'Title2',
      'assets/image.jpg',
    ),
    Category(
      Color(0xff00E9DA),
      Color(0xff5189EA),
      'Title3',
      'assets/image.jpg',
    ),
    Category(
      Color(0xffAF2D68),
      Color(0xff632376),
      'Title4',
      'assets/image.jpg',
    ),
    Category(
      Color(0xff36E892),
      Color(0xff33B2B9),
      'Title5',
      'assets/image.jpg',
    ),
    Category(
      Color(0xffF123C4),
      Color(0xff668CEA),
      'Title6',
      'assets/image.jpg',
    ),
  ];

  final TabController tabController;

  TabSearchView({Key key, this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
        //physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: <Widget>[
          Column(children: <Widget>[Flexible(child: ExamplePage())]),
          
          
        ]);
  }
}
