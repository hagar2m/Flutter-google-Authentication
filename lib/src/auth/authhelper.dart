import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

Future<FirebaseUser> loginWithGoogle() async {
  print('loginWithGoogle');
  GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

  FirebaseUser user = await _auth.signInWithGoogle(
    idToken: gSA.idToken,
    accessToken: gSA.accessToken
  );
  return user;
}

Future<Null> logoutWithGoogle() async {
  await _auth.signOut();
  await _googleSignIn.signOut();
  print('logoutWithGoogle');
}

