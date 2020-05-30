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
}
