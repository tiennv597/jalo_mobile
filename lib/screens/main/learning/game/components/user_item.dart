import 'package:flutter/material.dart';
import 'package:shinro_int2/constant/app_colors.dart' as COLORS;
import 'package:shinro_int2/models/game/info_user.dart';
class UserItem extends StatelessWidget {
  final User users;

  const UserItem({Key key, this.users}) : super(key: key);

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
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: COLORS.colorBlue2
                      ),
                  child: Center(
                    child: Image.asset('assets/gokaku.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(users.fullName),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
