import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth/authhelper.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  bool isLogging = false;
  bool loading = false;
  String userName = '';
  var user;

  Future loginClicked() async {
    setState(() {
      loading = true;
    });
    loginWithGoogle().then((FirebaseUser _user) {
      print('user: ${_user.toString()}');
      setState(() {
        loading = false;
        isLogging = true;
        userName = _user.displayName;
        user = _user;
      });
    }).catchError((e) {
      print('error: ${e.toString()}');
      setState(() {
        loading = false;
        isLogging = false;
      });
    });
  }

  logoutClicked() {
    logoutWithGoogle().whenComplete(() => setState(() {
          isLogging = false;
          user = null;
          userName = 'No user is logged in';
        }));
  }

  @override
  Widget build(BuildContext context) {
    String displayName = loading ? 'Loading ...' : 'Hello : $userName';

    return new Scaffold(
        appBar: new AppBar(
          title: Text('google Authentication'),
        ),
        body: Center(
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(displayName,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.display1),
            SizedBox(
              height: 30.0,
            ),
            RaisedButton(
              color: Colors.lightGreen,
              child: Text('Login'),
              onPressed: isLogging ? null : loginClicked,
            ),
            RaisedButton(
              color: Colors.red,
              child: Text('Logout'),
              onPressed: isLogging ? logoutClicked : null,
            ),
          ],
        )));
  }
}
