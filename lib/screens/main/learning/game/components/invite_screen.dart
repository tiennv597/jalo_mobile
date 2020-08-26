import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shinro_int2/models/user/user_model.dart';
import 'package:shinro_int2/screens/main/profile/controller/user_controller.dart';
import 'package:shinro_int2/socket/user_socket.dart';


class InviteScreen extends StatefulWidget {
  @override
  _InviteScreenState createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  UserController userController = Get.find();
  TextEditingController _searchQueryController;
  UserSocket userSocket = Get.find();
  bool _isSearching = false;
  String searchQuery = "";
  void initState() {
    _searchQueryController = TextEditingController();
    _isSearching = true;
    super.initState();
  }

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: TextField(
        controller: _searchQueryController,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: 'Search...',
          fillColor: Colors.grey,
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.black),
        ),
        style: const TextStyle(color: Colors.black, fontSize: 14.0),
        onChanged: (query) => updateSearchQuery(query),
      ),
    );
  }

  Widget _buildTitle(context) {
    return const Text('search');
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(
            Icons.clear,
          ),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
      print(searchQuery);
      userController.search(searchQuery);
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: _isSearching ? const BackButton() : Container(),
        title: _isSearching ? _buildSearchField() : _buildTitle(context),
        actions: _buildActions(),
      ),
      body: SafeArea(
          bottom: true,
          child: FutureBuilder(
              future: userController.search(searchQuery),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<User> users = snapshot.data;
                  return Container(
                    height: userController.entries.length > 3
                        ? 160
                        : userController.entries.length.toDouble() * 60,
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
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          "id: ${users[index].gender}",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ),
                                      Row(
                                        children: [],
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    userSocket.inviteInto(
                                        userController.userG, users[index]);
                                  },
                                  child: Icon(Icons.person_add),
                                )
                              ],
                            ),
                          );
                        }),
                  );
                }
              })),
    );
  }
}
