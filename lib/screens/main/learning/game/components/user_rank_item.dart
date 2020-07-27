import 'package:shinro_int2/constant/app_colors.dart' as COLORS;
import 'package:flutter/material.dart';
import 'package:shinro_int2/models/game/info_user.dart';

class UserRankItem extends StatelessWidget {
  final User user;

  const UserRankItem({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
                      shape: BoxShape.circle, gradient: COLORS.colorBlue2),
                  child: CircleAvatar(
                    child: new Text(user.fullName[0]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(user.fullName),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
