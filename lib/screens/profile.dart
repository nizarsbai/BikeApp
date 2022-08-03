import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:auth_bikeapp/screens/login_screen.dart';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              // CircleAvatar(
              //   radius: 40,
              //   //backgroundImage: NetworkImage(user.photoURL!),
              // ),
              const SizedBox(height: 15,),
              //Text(user.displayName!),
              const SizedBox(height: 5,),
              //Text(user.email!),
              ElevatedButton(
                onPressed: () async {
                  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
                  await googleSignIn.signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                }, 
                child: const Text("Log out"),
              )
            ],
          
        ),),
      )
    );
  }
}