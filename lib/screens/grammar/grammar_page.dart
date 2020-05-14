import 'dart:math';

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shinro_int2/network/api_service.dart';

class Post {
  final String title;
  final String body;

  Post(this.title, this.body);
}

class GrammarPage extends StatefulWidget {
  @override
  _GrammarPageState createState() => _GrammarPageState();
}

class _GrammarPageState extends State<GrammarPage> {
  final SearchBarController<Post> _searchBarController = SearchBarController();
  bool isReplay = false;

  Future<List<Post>> _getALlPosts(String text) async {
    //await Future.delayed(Duration(seconds: text.length == 4 ? 10 : 1));
    await Future.delayed(Duration(seconds: 0));
    if (isReplay) return [Post("Replaying !", "Replaying body")];
    //if (text.length == 5) throw Error();
    //if (text.length == 6) return [];
    List<Post> posts = [];
    posts.add(Post("value", "rrr"));
    final api = Provider.of<ApiService>(context, listen: false);
    api.getTasks().then((it) {
      //   it.forEach((f) {
      //     print(f.title);
      //     posts.add(Post("1", f.id.toString()));

      //   });
      //   return posts;
      // }).catchError((onError) {
      //   print(onError.toString());
       for (int i = 0; i < 10; i++) {
      posts
          .add(Post(it[i].id.toString(), it[i].url.toString()));
    }
      return posts;
    });
    // var random = new Random();
    // for (int i = 0; i < 10; i++) {
    //   posts
    //       .add(Post("$text $i", "body random number : ${random.nextInt(100)}"));
    // }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: SearchBar<Post>(
            searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
            headerPadding: EdgeInsets.symmetric(horizontal: 10),
            listPadding: EdgeInsets.symmetric(horizontal: 8),
            onSearch: _getALlPosts,
            searchBarController: _searchBarController,
            placeHolder: Text("placeholder"),
            cancellationWidget: Text("Cancel"),
            emptyWidget: Text("empty"),
            // indexedScaledTileBuilder: (int index) =>
            //     ScaledTile.count(1, index.isEven ? 2 : 1),
            header: Row(
              children: <Widget>[
                RaisedButton(
                  child: Text("sort"),
                  onPressed: () {
                    _searchBarController.sortList((Post a, Post b) {
                      return a.body.compareTo(b.body);
                    });
                  },
                ),
                RaisedButton(
                  child: Text("Desort"),
                  onPressed: () {
                    _searchBarController.removeSort();
                  },
                ),
                RaisedButton(
                  child: Text("Replay"),
                  onPressed: () {
                    isReplay = !isReplay;
                    _searchBarController.replayLastSearch();
                  },
                ),
              ],
            ),
            onCancelled: () {
              print("Cancelled triggered");
            },
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            //crossAxisCount: 2,
            onItemFound: (Post post, int index) {
              return ListTile(
                title: Text(post.title),
                //isThreeLine: true,
                subtitle: Text(post.body),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Detail()));
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Text("Detail"),
          ],
        ),
      ),
    );
  }
}
