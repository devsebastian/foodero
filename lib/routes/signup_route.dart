import 'package:cooking_app/utils/authenticate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController nameController = TextEditingController();

class SignUpRoute extends StatelessWidget {
  final Function _setLoggedIn;

  SignUpRoute(this._setLoggedIn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Theme.of(context).primaryColor,
              child: Opacity(
                  opacity: 1,
                  child: Image.asset(
                    "assets/images/409.jpg",
                    height: double.infinity,
                    colorBlendMode: BlendMode.darken,
                    color: Theme.of(context).primaryColor,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          SignUpScreen(_setLoggedIn)
        ],
      ),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  final Function _setLoggedIn;

  SignUpScreen(this._setLoggedIn);

  @override
  State<StatefulWidget> createState() {
    return SignUpScreenState();
  }
}

class SignUpScreenState extends State<SignUpScreen> {
  bool _nameFieldIsVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 42.0),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Visibility(
            visible: _nameFieldIsVisible ? true : false,
            child: TextField(
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black12),
                      borderRadius: BorderRadius.all(Radius.circular(6.0)))),
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                hintText: "Email Address",
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black12),
                    borderRadius: BorderRadius.all(Radius.circular(6.0)))),
          ),
          SizedBox(
            height: 24.0,
          ),
          TextField(
            obscureText: true,
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black12),
                    borderRadius: BorderRadius.all(Radius.circular(6.0)))),
          ),
          SizedBox(
            height: 24.0,
          ),
          FlatButton(
            onPressed: () {
              _nameFieldIsVisible
                  ? signUpWithEmail(nameController.text, emailController.text,
                      passwordController.text, widget._setLoggedIn)
                  : signInWithEmail(nameController.text, emailController.text,
                      passwordController.text, widget._setLoggedIn);
            },
            child: Text("Sign up"),
          ),
          SizedBox(
            height: 32.0,
          ),
          FlatButton(
            onPressed: () {
              setState(() {
                _nameFieldIsVisible = !_nameFieldIsVisible;
              });
            },
            child: Text(_nameFieldIsVisible == true
                ? "Already have an account? sign in"
                : "Dont have an account sign up"),
          )
        ],
      ),
    );
  }
}
