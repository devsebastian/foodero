import 'package:cloud_firestore/cloud_firestore.dart';

class MainFeedPost {
  String _id,
      _title,
      _description,
      _imageUri,
      _status,
      _username,
      _profilePicUri,
      _heroImageUri;
  int _likeCount, _commentCount;
  bool favourite;

  MainFeedPost.fromSnapshot(DocumentSnapshot document) {
    this._title = document["name"];
    this._description = document["description"];
    this._commentCount = document["commentCount"];
    this._likeCount = document["likeCount"];
    this._heroImageUri = document["heroImageUrl"];
    this._profilePicUri = document["profilePicUrl"];
    this._username = document["username"];
    this._status = document["status"];
    this._id = document.documentID;
  }

  MainFeedPost.fromFutureSnapshot(Future<DocumentSnapshot> d) {
    d.then((document) {
      print(document.documentID);
      this._title = document["name"];
      this._description = document["description"];
      this._commentCount = document["commentCount"];
      this._likeCount = document["likeCount"];
      this._heroImageUri = document["heroImageUrl"];
      this._profilePicUri = document["profilePicUrl"];
      this._username = document["username"];
      this._status = document["status"];
      this._id = document.documentID;
      print(_title);
    });
  }

  String get title => _title;

  String get description => _description;

  get commentCount => _commentCount;

  get likeCount => _likeCount;

  get heroImageUri => _heroImageUri;

  get profilePicUri => _profilePicUri;

  get username => _username;

  get status => _status;

  get imageUri => _imageUri;

  String get id => _id;
}
