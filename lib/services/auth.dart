import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todowebapp/screens/home.dart';
import 'package:todowebapp/services/database.dart';

class AuthService {
  Future<FirebaseUser> signInWithGoogle(BuildContext context) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    final GoogleSignInAccount _googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await _googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = await _firebaseAuth.signInWithCredential(credential);
    FirebaseUser userDetails = result.user;

    if (result == null) {
    } else {
      Map<String, String> userMap = {
        'userName': userDetails.displayName,
        'email': userDetails.email
      };

      DatabaseServices().uploadUserInfo(userDetails.uid, userMap);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Home(
                    userEmail: userDetails.email,
                    userName: userDetails.displayName,
                  )));
    }
    return userDetails;
  }
}
