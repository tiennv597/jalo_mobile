import 'package:shinro_int2/constant/app_properties.dart';
import 'package:flutter/material.dart';

import 'package:shinro_int2/models/product.dart';
import 'package:shinro_int2/screens/game/game_home_page.dart';

class RankList extends StatelessWidget {
  List<Product> products = [
    Product('assets/bad.png', 'Bag', 'Beautiful bag', 2.33),
    Product('assets/bad.png', 'Cap', 'Cap with beautiful design', 10),
    Product('assets/bad.png', 'Jeans', 'Jeans for you', 20),
    Product('assets/bad.png', 'Woman Shoes', 'Shoes with special discount', 30),
    Product('assets/bad.png', 'Bag Express', 'Bag for your shops', 40),
    Product('assets/bad.png', 'Jeans', 'Beautiful Jeans', 102.33),
    Product('assets/bad.png', 'Silver Ring', 'Description', 52.33),
    Product('assets/bad.png', 'Shoes', 'Description', 62.33),
    Product('assets/bad.png', 'Headphones', 'Description', 72.33),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              IntrinsicHeight(
                child: Container(
                  margin: const EdgeInsets.only(left: 16.0, right: 8.0),
                  width: 4,
                  color: mediumYellow,
                ),
              ),
              Center(
                  child: Text(
                'Rank',
                style: TextStyle(
                    color: darkGrey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              )),
            ],
          ),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) => new ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: InkWell(
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => GameHomePage())),
                  child: Container(
                      decoration: BoxDecoration(
                      ),
                      child: Text("Top 1")),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
