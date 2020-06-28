import 'package:flutter/material.dart';
import 'package:shinro_int2/models/trending.dart';
import 'package:shinro_int2/screens/main/components/trending_details_screen.dart';

class TopRatedListItem extends StatelessWidget {
  final int index;
  TopRatedListItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 160,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            TrendingDetailsScreen.routeName,
            arguments: {
              'id': topRatedList[index].id,
              'title': topRatedList[index].title,
              'imageUrl': topRatedList[index].imageUrl,
              'description': topRatedList[index].description,
              'rating': topRatedList[index].rating,
              'year': topRatedList[index].year,
              'duration': topRatedList[index].duration,
            },
          );
        },
        child: Column(
          children: <Widget>[
            Card(
              elevation: 10,
              child: Hero(
                tag: topRatedList[index].id,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(topRatedList[index].imageUrl),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              topRatedList[index].title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
