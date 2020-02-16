import 'package:cooking_app/routes/post_details_route.dart';
import 'package:cooking_app/ui/main_feed_row.dart';
import 'package:cooking_app/utils/main_feed_post.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/authenticate.dart';

class BookmarkedPostsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BookmarksFeed();
  }
}

class BookmarksFeed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BookmarksFeedState();
  }
}

class BookmarksFeedState extends State<BookmarksFeed> {
  List<MainFeedPost> posts = [];

  @override
  void initState() {
    super.initState();
    Firestore.instance.collection("users").document(uid).get().then((value) {
      Map m = value["bookmarked"];
      List<String> ids = [];
      m.forEach((key, val) {
        ids.add(key);
      });

      ids.forEach((id) {
        Firestore.instance
            .collection("mainFeedPosts")
            .document(id)
            .get()
            .then((value) {
          setState(() {
            posts.add(MainFeedPost.fromSnapshot(value));
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return posts.length == 0
        ? Container(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/5.gif",
              width: 32.0,
              height: 32.0,
            ),
          )
        : ListView.builder(
            itemCount: posts.length,
            itemBuilder: ((context, index) {
              return MainFeedRow(posts[index], () => print("tapped"), "key");
            }));
  }
}

//      StreamBuilder(
//      stream: Firestore.instance.collection("users").document(uid).snapshots(),
//      builder: (context, snapshots) {
//        if (!snapshots.hasData)
//          return Padding(
//            padding: const EdgeInsets.all(24.0),
//            child: Text("Loading..."),
//          );
//        return ListView.builder(
//          itemCount: snapshots.data.documents.length,
//          itemBuilder: (context, index) => MainFeedRow(
//              MainFeedPost.fromSnapshot(snapshots.data.documents[index]), () {
//            Navigator.push(
//                context,
//                MaterialPageRoute(
//                    builder: (context) => MainFeedPostDetailsRoute(
//                        snapshots.data.documents[index].documentID,
//                        snapshots.data.documents[index]["name"],
//                        snapshots.data.documents[index]["description"],
//                        snapshots.data.documents[index]["heroImageUrl"],
//                        "heroImageTag" + index.toString())));
//          }, "heroImageTag" + index.toString()),
//        );
//      },
//    );
