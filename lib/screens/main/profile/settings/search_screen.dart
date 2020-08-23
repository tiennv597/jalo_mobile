import 'package:flutter/material.dart';
import 'package:shinro_int2/models/user/user_model.dart';
import 'package:shinro_int2/screens/main/profile/controller/user_controller.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  UserController c = new UserController();
  TextEditingController _searchQueryController;
  bool _isSearching = false;
  String searchQuery = "";
  void initState() {
    _searchQueryController = TextEditingController();
    _isSearching = true;
    super.initState();
  }

  Widget _buildSearchField() {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: TextField(
        controller: _searchQueryController,
        autofocus: true,
        decoration: InputDecoration(
          hintText: "Search...",
          fillColor: Colors.grey,
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.black),
        ),
        style: TextStyle(color: Colors.black, fontSize: 14.0),
        onChanged: (query) => updateSearchQuery(query),
      ),
    );
  }

  Widget _buildTitle(context) {
    return Text("search");
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
      c.search(searchQuery);
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
        iconTheme: IconThemeData(
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
              future: c.search(searchQuery),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<User> users = snapshot.data;
                  return Container(
                    height: c.entries.length > 3
                        ? 160
                        : c.entries.length.toDouble() * 60,
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.7,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, bottom: 0, left: 8),
                                            child: RaisedButton(
                                              color: Colors.blue,
                                              onPressed: () {},
                                              child: const Text('Đồng ý',
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 32,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.7,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, bottom: 0, left: 8),
                                            child: RaisedButton(
                                              onPressed: () {},
                                              child: const Text('Xóa',
                                                  style:
                                                      TextStyle(fontSize: 14)),
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
              })),
    );
  }
}
