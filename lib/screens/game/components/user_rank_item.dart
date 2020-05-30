import 'package:shinro_int2/models/category.dart';
import 'package:flutter/material.dart';

class UserRankItem extends StatelessWidget {
  final Category category;

  const UserRankItem({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print("object");
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Card(
          child: ClipRRect(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  height: 20,
                  width: 20,
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
      ),
    );
  }
}
