import 'package:cooking_app/utils/main_feed_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'main_feed_row_like_button.dart';

class MainFeedRow extends StatelessWidget {
  final MainFeedPost _post;
  final Function onTap;
  final String _tag;

  MainFeedRow(this._post, this.onTap, this._tag);

  @override
  Widget build(BuildContext context) {
    double screenWidth = (MediaQuery.of(context).size.width / 1.7);

    return _post.title == null? Container() :InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12),
                child: CircleAvatar(
                    backgroundImage: NetworkImage(_post.profilePicUri)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_post.username,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600)),
                  Text(_post.status,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                      )),
                ],
              ),
              Spacer(),
              Icon(Icons.more_vert),
            ]),
            Hero(
              tag: _tag,
              child: FadeInImage(
                  placeholder: AssetImage("assets/images/blank.png"),
                  image: NetworkImage(_post.heroImageUri),
                  width: double.infinity,
                  fit: BoxFit.cover,
                  height: screenWidth),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 12.0, left: 12.0, right: 12.0, bottom: 8.0),
              child: Text(
                _post.title,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                _post.description,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400),
                maxLines: 3,
                textAlign: TextAlign.start,
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 12.0, bottom: 12.0, left: 12.0, right: 8.0),
                  child: LikeButton(),
                ),
                Container(
                  width: 64.0,
                  child: Text(
                    NumberFormat.compact().format(_post.likeCount),
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 12.0, bottom: 12.0, left: 12.0, right: 8.0),
                  child: SvgPicture.asset(
                    "assets/images/comment.svg",
                    width: 24.0,
                    height: 24.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  NumberFormat.compact().format(_post.commentCount),
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.black),
                ),
              ],
            ),
            SizedBox(
              height: 12.0,
            ),
            Container(
              height: 1.0,
              width: double.infinity,
              color: Colors.black12,
            )
          ],
        ),
      ),
    );
  }
}
