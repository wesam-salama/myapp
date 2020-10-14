// import 'package:ecommerce_user_side/helper/shared_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FbAuth {
  FbAuth._();
  static final FbAuth auth = FbAuth._();

  //-===================== login with Google ==========================
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GlobalKey<ScaffoldState> scaffoldKeyLogin = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffoldKeyRegister = GlobalKey<ScaffoldState>();

  Future<User> loginUsingGmail() async {
    try {
      // create google Account
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      // create authentaication object to get the  access token and token id
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      // get credintials
      String accesToken = googleSignInAuthentication.accessToken;
      String tokenId = googleSignInAuthentication.idToken;
      // create credintial object
      OAuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: tokenId, accessToken: accesToken);

      // create the user using credintials
      UserCredential authResult =
          await firebaseAuth.signInWithCredential(authCredential);

      if (authResult.user == null) {
        // return false;
      } else {
        return authResult.user;
      }
    } catch (error) {
      scaffoldKeyLogin.currentState.showSnackBar(
          // SnackBar(content: Text(error.toString().split('.')[1])));
          SnackBar(
              backgroundColor: Colors.red,
              content: Text('Check connection internet')));
    }
  }

// ===========================
  Future<User> registerUsingEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential authResult = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (authResult.user != null) {
        // authResult.user.sendEmailVerification();

        return authResult.user;
      } else {
        // return false;
      }
    } catch (error) {
      scaffoldKeyRegister.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(error.toString().split(',')[1])));
    }
  }

  Future<User> loginUsingEmailAndPassword(String email, String password) async {
    try {
      UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      if (authResult.user != null) {
        return authResult.user;
      } else {
        // return false;
        // print(false);
      }
    } catch (error) {
      scaffoldKeyLogin.currentState.showSnackBar(
          // SnackBar(content: Text(error.toString().split('.')[1])));
          SnackBar(
              backgroundColor: Colors.red,
              content: Text(error.toString().split(',')[1].substring(0, 25))));
    }
  }

  signOut() async {
    // ShaerdHelper.sHelper.setEmail(null);
    // ShaerdHelper.sHelper.setPhotoUrl(null);
    // ShaerdHelper.sHelper.setUid(null);
    // ShaerdHelper.sHelper.setUserName(null);
    // ShaerdHelper.sHelper.setValueisSeen(false);

    await firebaseAuth.signOut();
  }
}
