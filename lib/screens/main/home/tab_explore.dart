import 'package:flutter/material.dart';
import 'package:shinro_int2/models/trending.dart';
import 'package:shinro_int2/screens/main/components/top_rated_list_item.dart';
import 'package:shinro_int2/screens/main/components/vertical_list_item.dart';
import 'package:shinro_int2/screens/main/components/horizontal_list_item.dart';

class TabExplore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'New',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FlatButton(
                    child: Text('View All'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: trendingList.length,
                itemBuilder: (ctx, i) => HorizontalListItem(i),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Best of 2019',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FlatButton(
                    child: Text('View All'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width ,
              height: MediaQuery.of(context).size.height/4,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: bestList.length,
                itemBuilder: (ctx, i) => VerticalListItem(i),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Trending',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FlatButton(
                    child: Text('View All'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Container(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topRatedList.length,
                itemBuilder: (ctx, i) => TopRatedListItem(i),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
