import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
String uid;

Future<FirebaseUser> getUser() async {
  return _auth.currentUser().then((user) {
    uid = user.uid;
    return user;
  });
}

Future<bool> isLoggedIn() async {
  FirebaseUser _user = await getUser();
  return _user != null;
}

Future<bool> signUpWithEmail(
    String name, String email, String password, Function setLoggedIn) async {
  bool success = false;
  try {
    _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((authResult) {
      if (authResult.user != null) {
        uid = authResult.user.uid;
        setLoggedIn();
        success = true;
        updateDatabase(authResult.user, name, email, password);
      }
    });
  } catch (e) {
    print("dev error: " + e.toString());
  }
  return success;
}

Future<bool> signInWithEmail(
    String name, String email, String password, Function setLoggedIn) async {
  bool success = false;
  try {
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((authResult) {
      if (authResult.user != null) {
        uid = authResult.user.uid;
        setLoggedIn();
        success = true;
      }
    });
  } catch (e) {
    print("dev error: " + e.toString());
  }
  return success;
}

void signOut() {
  _auth.signOut();
}

void updateDatabase(
    FirebaseUser user, String name, String email, String password) {
  FirebaseAuth.instance.currentUser().then((user) {
    uid = user.uid;
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = name;
    user.updateProfile(updateInfo);
    Firestore.instance.collection("users").document(user.uid).setData(
        {"name": name, "emailId": email, "password": password,
        "followers" : 0, "following" : 0, "postCount" : 0},
        merge: true);
  });
}
