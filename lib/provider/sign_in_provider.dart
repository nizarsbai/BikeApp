import 'dart:convert';


import 'package:auth_bikeapp/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:twitter_login/twitter_login.dart';

class SignInProvider extends ChangeNotifier {
  // instance of firebaseauth, facebook and google
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FacebookAuth facebookAuth = FacebookAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  // final twitterLogin = TwitterLogin(
  //     apiKey: Config.apikey_twitter,
  //     apiSecretKey: Config.secretkey_twitter,
  //     redirectURI: "socialauth://");

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  // //hasError, errorCode, provider,uid, email, name, image_url
  bool _hasError = false;
  bool get hasError => _hasError;

  String? _errorCode;
  String? get errorCode => _errorCode;

  String? _provider;
  String? get provider => _provider;

  String? _uid;
  String? get uid => _uid;

  String? _name;
  String? get name => _name;

  String? _email;
  String? get email => _email;

  // ignore: non_constant_identifier_names
  String? _image_url;
  String? get image_url => _image_url;

  SignInProvider() {
    checkSignInUser();
  }

  Future checkSignInUser() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("signed_in") ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("signed_in", true);
    _isSignedIn = true;
    notifyListeners();
  }

  // Future signUpWithEmail(String email, String password) async {
  //   try {
  //     // signing to firebase user instance
  //     final User userDetails = (await firebaseAuth
  //             .createUserWithEmailAndPassword(email: email, password: password))
  //         .user!;

  //     // now save all values
  //     _name = userDetails.displayName;
  //     _email = userDetails.email;
  //     _image_url = userDetails.photoURL;
  //     _provider = "EMAIL";
  //     _uid = userDetails.uid;
  //     notifyListeners();
  //   } on FirebaseAuthException catch (e) {
  //     switch (e.code) {
  //       case "invalid-email":
  //         _errorCode = "Your email address appears to be malformed.";
  //         _hasError = true;
  //         notifyListeners();
  //         break;
  //       case "wrong-password":
  //         _errorCode = "Your password is wrong.";
  //         _hasError = true;
  //         notifyListeners();
  //         break;
  //       case "user-not-found":
  //         _errorCode = "User with this email doesn't exist.";
  //         _hasError = true;
  //         notifyListeners();
  //         break;
  //       case "user-disabled":
  //         _errorCode = "User with this email has been disabled.";
  //         _hasError = true;
  //         notifyListeners();
  //         break;
  //       case "too-many-requests":
  //         _errorCode = "Too many requests";
  //         _hasError = true;
  //         notifyListeners();
  //         break;
  //       case "operation-not-allowed":
  //         _errorCode = "Signing in with Email and Password is not enabled.";
  //         _hasError = true;
  //         notifyListeners();
  //         break;
  //       default:
  //         _errorCode = "An undefined Error happened.";
  //         _hasError = true;
  //         notifyListeners();
  //         break;
  //     }
  //   }
  //   // } else {
  //   //   _hasError = true;
  //   //   notifyListeners();
  //   // }
  // }

  Future signInWithEmail(String email, String password) async {
    // User? user = FirebaseAuth.instance.currentUser;
    // if (user != null) {
    // executing our authentication
    try {
      // signing to firebase user instance
      final User userDetails = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      // now save all values
      _name = userDetails.displayName;
      _email = userDetails.email;
      _image_url = userDetails.photoURL;
      _provider = "EMAIL";
      _uid = userDetails.uid;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          _errorCode = "Your email address appears to be malformed.";
          _hasError = true;
          notifyListeners();
          break;
        case "wrong-password":
          _errorCode = "Your password is wrong.";
          _hasError = true;
          notifyListeners();
          break;
        case "user-not-found":
          _errorCode = "User with this email doesn't exist.";
          _hasError = true;
          notifyListeners();
          break;
        case "user-disabled":
          _errorCode = "User with this email has been disabled.";
          _hasError = true;
          notifyListeners();
          break;
        case "too-many-requests":
          _errorCode = "Too many requests";
          _hasError = true;
          notifyListeners();
          break;
        case "operation-not-allowed":
          _errorCode = "Signing in with Email and Password is not enabled.";
          _hasError = true;
          notifyListeners();
          break;
        default:
          _errorCode = "An undefined Error happened.";
          _hasError = true;
          notifyListeners();
          break;
      }
    }
    // } else {
    //   _hasError = true;
    //   notifyListeners();
    // }
  }

  // sign in with google
  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      // executing our authentication
      try {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        // signing to firebase user instance
        final User userDetails =
            (await firebaseAuth.signInWithCredential(credential)).user!;

        // now save all values
        _name = userDetails.displayName;
        _email = userDetails.email;
        _image_url = userDetails.photoURL;
        _provider = "GOOGLE";
        _uid = userDetails.uid;
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "account-exists-with-different-credential":
            _errorCode =
                "You already have an account with us. Use correct provider";
            _hasError = true;
            notifyListeners();
            break;

          case "null":
            _errorCode = "Some unexpected error while trying to sign in";
            _hasError = true;
            notifyListeners();
            break;
          default:
            _errorCode = e.toString();
            _hasError = true;
            notifyListeners();
        }
      }
    } else {
      _hasError = true;
      notifyListeners();
    }
  }

  // // sign in with twitter
  // Future signInWithTwitter() async {
  //   final authResult = await twitterLogin.loginV2();
  //   if (authResult.status == TwitterLoginStatus.loggedIn) {
  //     try {
  //       final credential = TwitterAuthProvider.credential(
  //           accessToken: authResult.authToken!,
  //           secret: authResult.authTokenSecret!);
  //       await firebaseAuth.signInWithCredential(credential);

  //       final userDetails = authResult.user;
  //       // save all the data
  //       _name = userDetails!.name;
  //       _email = firebaseAuth.currentUser!.email;
  //       _image_url = userDetails.thumbnailImage;
  //       _uid = userDetails.id.toString();
  //       _provider = "TWITTER";
  //       _hasError = false;
  //       notifyListeners();
  //     } on FirebaseAuthException catch (e) {
  //       switch (e.code) {
  //         case "account-exists-with-different-credential":
  //           _errorCode =
  //               "You already have an account with us. Use correct provider";
  //           _hasError = true;
  //           notifyListeners();
  //           break;

  //         case "null":
  //           _errorCode = "Some unexpected error while trying to sign in";
  //           _hasError = true;
  //           notifyListeners();
  //           break;
  //         default:
  //           _errorCode = e.toString();
  //           _hasError = true;
  //           notifyListeners();
  //       }
  //     }
  //   } else {
  //     _hasError = true;
  //     notifyListeners();
  //   }
  // }

  // sign in with facebook
  Future signInWithFacebook() async {
    final LoginResult result = await facebookAuth.login();
    // getting the profile
    final graphResponse = await http.get(Uri.parse(
        'https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=${result.accessToken!.token}'));

    final profile = jsonDecode(graphResponse.body);

    if (result.status == LoginStatus.success) {
      try {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        await firebaseAuth.signInWithCredential(credential);
        // saving the values
        _name = profile['name'];
        _email = profile['email'];
        _image_url = profile['picture']['data']['url'];
        _uid = profile['id'];
        _hasError = false;
        _provider = "FACEBOOK";
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "account-exists-with-different-credential":
            _errorCode =
                "You already have an account with us. Use correct provider";
            _hasError = true;
            notifyListeners();
            break;

          case "null":
            _errorCode = "Some unexpected error while trying to sign in";
            _hasError = true;
            notifyListeners();
            break;
          default:
            _errorCode = e.toString();
            _hasError = true;
            notifyListeners();
        }
      }
    } else {
      _hasError = true;
      notifyListeners();
    }
  }

  // ENTRY FOR CLOUDFIRESTORE
  Future getUserDataFromFirestore(uid) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((DocumentSnapshot snapshot) => {
              _uid = snapshot['uid'],
              _name = snapshot['name'],
              _email = snapshot['email'],
              _image_url = snapshot['image_url'],
              _provider = snapshot['provider'],
            });
  }

  Future saveDataToFirestore() async {
    final DocumentReference r =
        FirebaseFirestore.instance.collection("users").doc(uid);
    await r.set({
      "name": _name,
      "email": _email,
      "uid": _uid,
      "image_url": _image_url,
      "provider": _provider,
    });
    notifyListeners();
  }

  Future saveDataToSharedPreferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString('name', _name!);
    await s.setString('email', _email!);
    await s.setString('uid', _uid!);
    await s.setString('image_url', _image_url!);
    await s.setString('provider', _provider!);
    notifyListeners();
  }

  Future getDataFromSharedPreferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _name = s.getString('name');
    _email = s.getString('email');
    _image_url = s.getString('image_url');
    _uid = s.getString('uid');
    _provider = s.getString('provider');
    notifyListeners();
  }

  // checkUser exists or not in cloudfirestore
  Future<bool> checkUserExists() async {
    DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if (snap.exists) {
      print("EXISTING USER");
      return true;
    } else {
      print("NEW USER");
      return false;
    }
  }

  // signout
  Future userSignOut() async {
    await firebaseAuth.signOut;
    await googleSignIn.signOut();
    await facebookAuth.logOut();

    _isSignedIn = false;
    notifyListeners();
    // clear all storage information
    clearStoredData();
  }

  Future clearStoredData() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.clear();
  }

  void phoneNumberUser(User user, email, name) {
    _name = name;
    _email = email;
    _image_url =
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTN9TaGrF3qmBtBoXN5TaTdijk8dUfq2z7w6a-QjVoEjtxv2f2IcWph0-e7avSfpgTjdg&usqp=CAU";
    _uid = user.phoneNumber;
    _provider = "PHONE";
    notifyListeners();
  }

  void signUpUser(User user, email, name) {
    _name = name;
    _email = email;
    _image_url =
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTN9TaGrF3qmBtBoXN5TaTdijk8dUfq2z7w6a-QjVoEjtxv2f2IcWph0-e7avSfpgTjdg&usqp=CAU";
    _uid = user.uid;
    _provider = "EMAIL";
    notifyListeners();
  }
}