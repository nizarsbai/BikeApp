import 'package:auth_bikeapp/screens/login_screen.dart';
import 'package:auth_bikeapp/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  //GoogleSignInAccount? user=_googleSignIn.currentUser;

    return MaterialApp(
      title: 'Email And Password Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
    );
  }
}

