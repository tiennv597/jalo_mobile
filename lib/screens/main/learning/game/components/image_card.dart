import 'package:shinro_int2/models/category.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final Category category;

  const ImageCard({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Card(
        child: ClipRRect(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [category.begin, category.end],
                    )),
                child: Center(
                  child: Image.asset(category.image),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
