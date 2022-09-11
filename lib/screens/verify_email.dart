import 'dart:async';

import 'package:auth_bikeapp/screens/principal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final auth = FirebaseAuth.instance;
  User? user;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    user!.sendEmailVerification();

    timer = Timer.periodic(
      const Duration(seconds: 2), 
      (timer) {
        checkEmailVerified();
      }
    );
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Email Verfication"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Please check your email and verify your account! ${user!.email}"),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user!.reload();
    if(user!.emailVerified) {
      timer!.cancel();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const principal()));
    }
  }
}