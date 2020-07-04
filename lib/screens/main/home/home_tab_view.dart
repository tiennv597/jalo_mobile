import 'package:shinro_int2/models/category.dart';
import 'package:flutter/material.dart';
import '../components/category_card.dart';
import 'explore_screen.dart';
import 'hot_screen.dart';
import 'home_screen.dart';

class HomeTabView extends StatelessWidget {
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

  HomeTabView({Key key, this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
        //physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: <Widget>[
          Column(children: <Widget>[Flexible(child: HomeScreen())]),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: HotScreen())
          ]),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.all(8.0),
                    height: MediaQuery.of(context).size.height / 9,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (_, index) => CategoryCard(
                              category: categories[index],
                            ))),
                SizedBox(
                  height: 16.0,
                ),
                Flexible(child: ExploreScreen()),
              ],
            ),
          ),
        ]);
  }
}
