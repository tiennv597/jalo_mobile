import 'package:flutter/material.dart';
import 'package:shinro_int2/models/category.dart';

import 'user_item.dart';

class UserListModal {
  mainBottomSheet(BuildContext context, List<Category> categories) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16.0),
              topRight: const Radius.circular(16.0)),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height / 2.2,
            child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) => UserItem(
                      category: categories[index],
                    )),
          );
        });
  }

  // ListTile _createTile(
  //     BuildContext context, String name, IconData icon, Function action) {
  //   return ListTile(
  //     leading: Icon(icon),
  //     title: Text(name),
  //     onTap: () {
  //       Navigator.pop(context);
  //       action();
  //     },
  //   );
  // }

  // _action1() {
  //   print('action 1');
  // }

  // _action2() {
  //   print('action 2');
  // }

  // _action3() {
  //   print('action 3');
  // }
}
