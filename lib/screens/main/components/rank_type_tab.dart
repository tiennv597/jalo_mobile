import 'package:flutter/material.dart';
import 'package:shinro_int2/models/category.dart';
import 'package:shinro_int2/screens/main/components/category_card.dart';
import 'package:shinro_int2/screens/main/components/recommended_list2.dart';


class RankTypeTab extends StatelessWidget {
  // List<Category> categories = [
  //   Category(
  //     Color(0xffFCE183),
  //     Color(0xffF68D7F),
  //     'Gadgets',
  //     'assets/fujisan.png',
  //   ),
  //   Category(
  //     Color(0xffF749A2),
  //     Color(0xffFF7375),
  //     'Clothes',
  //     'assets/fujisan.png',
  //   ),
  //   Category(
  //     Color(0xff00E9DA),
  //     Color(0xff5189EA),
  //     'Fashion',
  //     'assets/fujisan.png',
  //   ),
  //   Category(
  //     Color(0xffAF2D68),
  //     Color(0xff632376),
  //     'Home',
  //     'assets/fujisan.png',
  //   ),
  //   Category(
  //     Color(0xff36E892),
  //     Color(0xff33B2B9),
  //     'Beauty',
  //     'assets/fujisan.png',
  //   ),
  //   Category(
  //     Color(0xffF123C4),
  //     Color(0xff668CEA),
  //     'Appliances',
  //     'assets/fujisan.png',
  //   ),
  // ];

  TabController tabController;

  RankTypeTab({Key key, this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height / 9);
    return TabBarView(
        controller: tabController,
        children: <Widget>[
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: RecommendedList2())
          ]),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: RecommendedList2())
          ]),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: RecommendedList2())
          ]),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: RecommendedList2())
          ]),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: RecommendedList2())
          ]),
        ]);
  }
}
