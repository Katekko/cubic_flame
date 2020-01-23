import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'repository/auth.repository.dart';

class DomainAuthService {
  AuthRepository authRepository;
  DomainAuthService({@required this.authRepository});

  Future<String> authenticatePlayer() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      bool isAuthenticate = prefs.containsKey('uid');
      if (isAuthenticate) {
        return prefs.getString('uid');
      } else {
        FirebaseUser user = await _handleSignInGoogle();
        prefs.setString('uid', user.uid);
        return user.uid;
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<FirebaseUser> _handleSignInGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    FirebaseAuth _auth = FirebaseAuth.instance;

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    return user;
  }
}
