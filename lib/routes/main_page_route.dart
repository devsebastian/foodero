import 'package:cooking_app/screens/bookmarked_posts_screen.dart';
import 'package:cooking_app/screens/new_post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../screens/main_feed_screen.dart';
import '../screens/user_profile_route.dart';

class MainPageRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainPageScreen();
  }
}

class MainPageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageScreenState();
  }
}

class MainPageScreenState extends State<MainPageScreen> {
  int _pageIndex = 0;

  List _screens = [
    {
      "name": "Foodero",
      "screen": MainFeedScreen(),
    },
    {
      "name": "Bookmarked",
      "screen": BookmarkedPostsScreen(),
    },
    {
      "name": "New",
      "screen": NewPostScreen(),
    },
    {
      "name": "Notifications",
      "screen": Container(),
    },
    {
      "name": "elonmusk",
      "screen": UserProfileScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            if (index == 2) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return NewPostRoute();
              }));
            } else {
              setState(() {
                _pageIndex = index;
              });
            }
          },
          currentIndex: _pageIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("Home")),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_border), title: Text("Bookmarks")),
            BottomNavigationBarItem(icon: Icon(Icons.add), title: Text("New")),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_none),
                title: Text("Notifications")),
            BottomNavigationBarItem(
                icon: Icon(Icons.supervised_user_circle),
                title: Text("Profile")),
          ],
        ),
        appBar: AppBar(
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (_) {
                FirebaseAuth.instance.signOut();
                SystemNavigator.pop();
              },
              itemBuilder: (_) {
                return [
                  PopupMenuItem(
                    value: "Sign Out",
                    child: Text(
                      "Sign Out",
                      style: TextStyle(fontFamily: "Roboto"),
                    ),
                  )
                ];
              },
            )
          ],
          title: Text(
            _screens[_pageIndex]["name"],
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        body: _screens[_pageIndex]["screen"]);
  }
}
