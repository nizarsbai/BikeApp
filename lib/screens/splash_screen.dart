import 'dart:async';

import 'package:auth_bikeapp/provider/sign_in_provider.dart';
import 'package:auth_bikeapp/screens/home_screen.dart';
import 'package:auth_bikeapp/screens/login_screen.dart';
import 'package:auth_bikeapp/screens/principal.dart';
import 'package:auth_bikeapp/utils/config.dart';
import 'package:auth_bikeapp/utils/next_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // init state
  @override
  void initState() {
    final sp = context.read<SignInProvider>();
    super.initState();
    // create a timer of 2 seconds
    Timer(const Duration(seconds: 2), () {
      sp.isSignedIn == false
          ? nextScreenReplace(context, const LoginScreen())
          : nextScreenReplace(context, const principal());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Image(
          image: AssetImage(Config.app_icon),
          height: 200,
          width: 200,
        )),
      ),
    );
  }
}