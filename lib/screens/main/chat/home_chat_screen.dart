import 'package:flutter/material.dart';
import 'components/category_selector.dart';
import 'components/favorite_contacts.dart';
import 'components/recent_chats.dart';

class ChatHomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ChatHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          CategorySelector(),
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  FavoriteContacts(),
                  RecentChats(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
