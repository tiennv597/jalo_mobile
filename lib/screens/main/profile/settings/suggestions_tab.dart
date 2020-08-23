import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shinro_int2/models/user/user_model.dart';
import 'package:shinro_int2/screens/main/profile/controller/user_controller.dart';

class SuggestionsScreen extends StatelessWidget {
  final UserController c = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Lời mời kết bạn"),
                        )
                      ],
                    ),
                  ),
                  requestsBuilder(),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Gợi ý kết bạn"),
                        )
                      ],
                    ),
                  ),
                  suggestionsBuilder(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget requestsBuilder() {
    return FutureBuilder(
        future: c.suggestions(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<User> users = snapshot.data;
            return Container(
              height:
                  c.entries.length > 3 ? 160 : c.entries.length.toDouble() * 60,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 36,
                            backgroundColor: Colors.blue,
                            backgroundImage: NetworkImage("userAvatar"),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 8),
                                child: Text(
                                  '${users[index].firstName} ${users[index].lastName}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 4, bottom: 4, left: 8),
                                child: Text(
                                  "id: 1232316",
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 32,
                                    width:
                                        MediaQuery.of(context).size.width / 2.7,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0, bottom: 0, left: 8),
                                      child: RaisedButton(
                                        color: Colors.blue,
                                        onPressed: () {},
                                        child: const Text('Đồng ý',
                                            style: TextStyle(fontSize: 14)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 32,
                                    width:
                                        MediaQuery.of(context).size.width / 2.7,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0, bottom: 0, left: 8),
                                      child: RaisedButton(
                                        onPressed: () {},
                                        child: const Text('Xóa',
                                            style: TextStyle(fontSize: 14)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            );
          }
        });
  }

  Widget suggestionsBuilder() {
    return FutureBuilder(
        future: c.suggestions(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<User> users = snapshot.data;
            return Container(
              height:
                  c.entries.length > 3 ? 160 : c.entries.length.toDouble() * 60,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 36,
                            backgroundColor: Colors.blue,
                            backgroundImage: NetworkImage("userAvatar"),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 0, bottom: 0, left: 8),
                                child: Text(
                                  '${users[index].firstName} ${users[index].lastName}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 4, bottom: 4, left: 8),
                                child: Text(
                                  "id: 1232316",
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 32,
                                    width:
                                        MediaQuery.of(context).size.width / 2.7,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0, bottom: 0, left: 8),
                                      child: RaisedButton(
                                        color: Colors.blue,
                                        onPressed: () {},
                                        child: const Text('Kết bạn',
                                            style: TextStyle(fontSize: 14)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 32,
                                    width:
                                        MediaQuery.of(context).size.width / 2.7,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0, bottom: 0, left: 8),
                                      child: RaisedButton(
                                        onPressed: () {},
                                        child: const Text('Xóa',
                                            style: TextStyle(fontSize: 14)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            );
          }
        });
  }
}
