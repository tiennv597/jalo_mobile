import 'package:flutter/material.dart';
import 'package:shinro_int2/screens/main/components/trending_details_screen.dart';
import 'package:shinro_int2/models/trending.dart';

class HorizontalListItem extends StatelessWidget {
  final int index;
  HorizontalListItem(this.index);

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
              'id': trendingList[index].id,
              'title': trendingList[index].title,
              'imageUrl': trendingList[index].imageUrl,
              'description': trendingList[index].description,
              'rating': trendingList[index].rating,
              'year': trendingList[index].year,
              'duration': trendingList[index].duration,
            },
          );
        },
        child: Column(
          children: <Widget>[
            Card(
              elevation: 10,
              child: Hero(
                tag: trendingList[index].id,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(trendingList[index].imageUrl),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              trendingList[index].title,
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
