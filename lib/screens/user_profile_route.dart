import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../utils/authenticate.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ProfileHeader(),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            "Recipes",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 1.0),
          child: GridView(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              UserProfilePostRow("Pizza Arrabiatta",
                  "https://www.kingarthurflour.com/sites/default/files/recipe_legacy/20-3-large.jpg"),
              UserProfilePostRow("Chicken Lababdar",
                  "https://realfood.tesco.com/media/images/RFO-1400x919-DavidsCurry-03186c71-75ff-4976-bf1f-24ca8c9aa06c-0-1400x919.jpg"),
              UserProfilePostRow("Yellow Sauce Pasta",
                  "https://www.seriouseats.com/2019/08/20190809-burst-tomato-xo-pasta-vicky-wasik21--1500x1125.jpg"),
              UserProfilePostRow("Sphagetti",
                  "https://www.bbcgoodfood.com/sites/default/files/recipe-collections/collection-image/2013/05/spaghetti-bolognese_2.jpg"),
              UserProfilePostRow("Cheese Pizza",
                  "https://www.dudleysquaregrille.com/files/images/about-us.jpg"),
            ],
          ),
        )
      ],
    );
  }
}

class ProfileHeader extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileHeaderState();
  }
}

class ProfileHeaderState extends State<ProfileHeader> {
  String _name, _descrition;
  int _followers, _following, _posts;

  @override
  void initState() {
    super.initState();
    Firestore.instance
        .collection("users")
        .document(uid)
        .get()
        .then((docSnapshot) {
      setState(() {
        _name = docSnapshot["name"];
        print(_name);
        _posts = docSnapshot["postCount"];
        _followers = docSnapshot["followers"];
        _following = docSnapshot["following"];
        _descrition = docSnapshot["description"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12.0, right: 12.0, left: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 45.0,
                backgroundImage: NetworkImage(
                    "https://amp.businessinsider.com/images/5d4ae5ea100a2411da63051d-750-562.jpg"),
              ),
              ProfileHeaderItem(_posts, "Posts"),
              ProfileHeaderItem(_followers, "Followers"),
              ProfileHeaderItem(_following, "Following"),
            ],
          ),
          SizedBox(
            height: 12.0,
          ),
          Text(
            _name == null ? "" : _name,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
          ),
          Status(_descrition),
        ],
      ),
    );
  }
}

class Status extends StatelessWidget {
  final String _text;

  Status(this._text);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text != null && _text.length > 0
          ? _text
          : "Please add a description about yourself",
      style: TextStyle(fontSize: 14.0),
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class UserProfilePostRow extends StatelessWidget {
  final String _src;
  final String _name;

  UserProfilePostRow(this._name, this._src);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 1.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Image.network(_src,
                    width: double.infinity, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      _name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14.0),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.favorite_border,
                            size: 18, color: Colors.black54),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            "12 likes",
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black54),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class ProfileHeaderItem extends StatelessWidget {
  final int _count;
  final String _label;

  ProfileHeaderItem(this._count, this._label);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            _count == null ? "0" : _count.toString(),
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
          ),
          Text(_label),
        ],
      ),
    );
  }
}
