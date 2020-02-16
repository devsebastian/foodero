import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_app/utils/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/strings.dart';
import 'package:intl/intl.dart';

bool _showComments = false;

class MainFeedPostDetailsRoute extends StatelessWidget {
  final String _id;
  final String _heroImageUri;
  final String _tag;
  final String _title;
  final String _description;

  MainFeedPostDetailsRoute(
      this._id, this._title, this._description, this._heroImageUri, this._tag);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Foodero",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        body: MainFeedPostDetailsPage(_id, _title, _description, _heroImageUri,
            _tag, MediaQuery.of(context).size.width));
  }
}

class MainFeedPostDetailsPage extends StatefulWidget {
  final String _id;
  final double screenWidth;
  final String _tag;
  final String _heroImageUri;
  final String _title, _description;

  MainFeedPostDetailsPage(
    this._id,
    this._title,
    this._description,
    this._heroImageUri,
    this._tag,
    this.screenWidth,
  );

  @override
  State<StatefulWidget> createState() {
    return MainFeedPostDetailsPageState();
  }
}

class MainFeedPostDetailsPageState extends State<MainFeedPostDetailsPage> {
  double heroImageHeight;
  List directions = [];
  List ingredients = [];
  String description,
      title,
      status,
      username,
      profilePicUri,
      heroImageUri,
      userId,
      userDescription,
      postId;
  int commentCount, likeCount;

  @override
  void initState() {
    super.initState();
    _showComments = false;
    heroImageHeight = widget.screenWidth / 1.3;
    Firestore.instance
        .collection("mainFeedPostDetails")
        .document(widget._id)
        .get()
        .then((document) {
      if (document.exists) {
        setState(() {
          title = document["name"];
          description = document["description"];
          status = document["status"];
          username = document["username"];
          profilePicUri = document["profilePicUrl"];
          heroImageUri = document["heroImageUrl"];
          commentCount = document["commentCount"];
          likeCount = document["likeCount"];
          userId = uid;
          userDescription = document["userDescription"];
          directions = document["directions"];
          ingredients = document["ingredients"];
          postId = document.documentID;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Hero(
                tag: widget._tag,
                child: Image(
                  image: NetworkImage(widget._heroImageUri),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: heroImageHeight,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            widget._title,
                            style: Theme.of(context).textTheme.subtitle,
                            textAlign: TextAlign.start,
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Firestore.instance
                                  .collection("users")
                                  .document(uid)
                                  .setData({
                                "bookmarked": {
                                  postId: "true",
                                }
                              }, merge: true);

//                              Firestore.instance
//                                  .collection("bookmarked")
//                                  .document(uid)
//                                  .updateData({
//                                "bookmarks": {
//                                  "0": {
//                                    "username": username,
//                                    "commentCount": commentCount,
//                                    "likeCount": likeCount,
//                                    "description": description,
//                                    "heroImageUrl": heroImageUri,
//                                    "name": title,
//                                    "profilePicUrl": profilePicUri,
//                                    "status": status
//                                  }
//                                }
//                              });
                            },
                            child: SvgPicture.asset(
                              "assets/images/bookmark.svg",
                              color: Colors.blue,
                              colorBlendMode: BlendMode.color,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        "27.9k Views",
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text(
                          description == null
                              ? widget._description
                              : description,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 16.0)),
                      SizedBox(
                        height: 24.0,
                      ),
                      Text(
                        "Ingredients",
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Ingredients(ingredients),
                      SizedBox(
                        height: 24.0,
                      ),
                      Text(
                        "Directions",
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Directions(directions),
                      SizedBox(
                        height: 32.0,
                      ),
                    ],
                  )),
              commentCount == null
                  ? SizedBox.shrink()
                  : CommentsBar(widget._id, commentCount),
              Container(
                height: 52.0,
                color: Colors.black12,
              ),
              username == null
                  ? SizedBox.shrink()
                  : AboutSection(
                      username, "Delhi", profilePicUri, userDescription),
            ],
          ),
        ),
        likeCount == null ? SizedBox.shrink() : LikeBar(likeCount),
      ],
    );
  }
}

class LikeBar extends StatelessWidget {
  final int _likeCount;

  LikeBar(this._likeCount);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Card(
        elevation: 20,
        margin: EdgeInsets.only(bottom: 0.0),
        child: Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Icon(Icons.favorite_border),
              Text(" Likes " +
                  NumberFormat.compact().format(_likeCount).toString()),
              SizedBox(
                width: 12.0,
              ),
              Icon(Icons.share),
              Text(" Share"),
              Spacer(),
              Icon(Icons.more_horiz)
            ],
          ),
        ),
      ),
    );
  }
}

class CommentsBar extends StatefulWidget {
  final int _commentCount;
  final String _id;

  CommentsBar(this._id, this._commentCount);

  @override
  State<StatefulWidget> createState() {
    return CommentsBarState();
  }
}

class CommentsBarState extends State<CommentsBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 1.0,
          color: Colors.black12,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Pierre-Person.jpg/220px-Pierre-Person.jpg"),
                ),
              ),
              Expanded(
                  child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Comment",
                    contentPadding: EdgeInsets.all(8.0)),
              )),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (widget._commentCount > 0) _showComments = true;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Text(
                    NumberFormat.compact().format(widget._commentCount),
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          ),
        ),
        Visibility(
          visible: _showComments,
          child: StreamBuilder(
            stream: Firestore.instance
                .collection("comments")
                .document(widget._id)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return CommentSection(snapshot.data["replies"]);
              } else {
                return Text("loading");
              }
            },
          ),
        ),
      ],
    );
  }
}

class CommentSection extends StatelessWidget {
  final List _replies;

  CommentSection(this._replies);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _replies.length,
        itemBuilder: (context, index) {
          var comment = _replies[index];
          return Column(
            children: <Widget>[
              CommentRow(
                  comment["userId"],
                  comment["username"],
                  comment["userProfilePicUrl"],
                  comment["body"],
                  DateTime.fromMillisecondsSinceEpoch(
                      comment["dateTime"].millisecondsSinceEpoch)),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child:
                    comment["replies"] != null && comment["replies"].length > 0
                        ? CommentSection(comment["replies"])
                        : SizedBox.shrink(),
              )
            ],
          );
        });
  }
}

class CommentRow extends StatelessWidget {
  final String _userId, _username, _profilePicUrl, _body;
  final DateTime _date;

  CommentRow(this._userId, this._username, this._profilePicUrl, this._body,
      this._date);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
          border: Border(left: BorderSide(color: Colors.black12, width: 1))),
      padding: EdgeInsets.only(left: 11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(backgroundImage: NetworkImage(_profilePicUrl)),
              Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(_username,
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    Text(DateFormat("MMM dd").format(_date)),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(_body),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              "Reply",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class Ingredients extends StatelessWidget {
  final _ingredients;

  Ingredients(this._ingredients);

  @override
  Widget build(BuildContext context) {
    return _ingredients != null && _ingredients.length > 0
        ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _ingredients.length,
            itemBuilder: (context, index) =>
                IngredientsRow(_ingredients[index]))
        : Text(Strings.NoDataAvailable);
  }
}

class Directions extends StatelessWidget {
  final _directions;

  Directions(this._directions);

  @override
  Widget build(BuildContext context) {
    return _directions != null && _directions.length > 0
        ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _directions.length,
            itemBuilder: (context, index) =>
                StepsRow(index + 1, _directions[index].toString()))
        : Text(Strings.NoDataAvailable);
  }
}

class AboutSection extends StatelessWidget {
  final String _profileImageUrl;
  final String _name;
  final String _status;
  final String _description;

  AboutSection(
      this._name, this._status, this._profileImageUrl, this._description);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24.0),
      margin: EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: <Widget>[
            CircleAvatar(backgroundImage: NetworkImage(_profileImageUrl)),
            SizedBox(
              width: 12.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(_name,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700)),
                Text(_status,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black54,
                    )),
              ],
            ),
            Spacer(),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Text(
                  "Follow",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ]),
          SizedBox(
            height: 24.0,
          ),
          Text(_description),
          SizedBox(
            height: 52.0,
          )
        ],
      ),
    );
  }
}

class IngredientsRow extends StatefulWidget {
  final String _body;

  IngredientsRow(this._body);

  @override
  State<StatefulWidget> createState() {
    return IngredientsRowState();
  }
}

class IngredientsRowState extends State<IngredientsRow> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Checkbox(
          value: _isChecked,
          onChanged: (val) {
            setState(() {
              _isChecked = val;
            });
          },
        ),
        Expanded(
            child: Text(
          widget._body,
          style: TextStyle(fontSize: 14.0),
        )),
      ],
    );
  }
}

class StepsRow extends StatelessWidget {
  final String direction;
  final int pos;

  StepsRow(this.pos, this.direction);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  margin: EdgeInsets.only(right: 12.0),
//                  padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  child: Text(
                    pos.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                        color: Colors.white),
                  )),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "STEP",
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      direction,
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )
    ]);
  }
}
