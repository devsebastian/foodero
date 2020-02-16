import 'package:cloud_firestore/cloud_firestore.dart';

class MainFeedPostDetails {
  String _title,
      _description,
      _status,
      _username,
      _profilePicUri,
      _heroImageUri,
      _userId,
      _id,
      _userDescription;
  List<String> _ingredients, _directions;
  int _likeCount, _viewCount, _commentCount;

  MainFeedPostDetails.fromDocumentId(String id) {
    Firestore.instance
        .collection("mainFeedPostDetails")
        .document(id)
        .get()
        .then((document) {
      if (document.exists) {
        this._title = document["name"];
        this._description = document["description"];
        this._status = document["status"];
        this._username = document["username"];
        this._profilePicUri = document["profilePicUrl"];
        this._heroImageUri = document["heroImageUrl"];
        this._commentCount = document["commentCount"];
        this._likeCount = document["likeCount"];
        this._id = document.documentID;
        this._userId = document["userId"];
        this._userDescription = document["userDescription"];
      }
    });
  }



  get description => _description;

  get commentCount => _commentCount;

  get viewCount => _viewCount;

  get likeCount => _likeCount;

  get directions => _directions;

  List<String> get ingredients => _ingredients;

  get userDescription => _userDescription;

  get userId => _userId;

  get id => _id;

  get heroImageUri => _heroImageUri;

  get profilePicUri => _profilePicUri;

  get username => _username;

  get status => _status;

  String get title => _title;
}
