import 'package:auth_bikeapp/model/user_model.dart';
import 'package:auth_bikeapp/screens/login_screen.dart';
import 'package:auth_bikeapp/screens/principal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../provider/sign_in_provider.dart';
import '../utils/next_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
User? user = FirebaseAuth.instance.currentUser;
UserModel loggedInUser = UserModel();

Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

    /*
    FirebaseFirestore.instance
    .collection("users")
    .doc(user!.uid)
    .get()
    .then((value){
        this.loggedInUser=UserModel.fromMap(value.data());
        setState(() {});
        
    }); */
  }

  @override
  Widget build(BuildContext context) {
        final sp = context.watch<SignInProvider>();
    return Scaffold(
      appBar: AppBar(title: Text("Bike App"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 150,
                child: Image.asset("assets/bikeAppLogo.png",
                fit: BoxFit.contain),
            ),
              Text("Welcome Back",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage("${sp.imageUrl}"),
              radius: 50,
            ),
            const SizedBox(
              height: 20,
            ),
              /*
              Text("${loggedInUser.firstName} ${loggedInUser.lastName}",
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500
                )),
              Text("${loggedInUser.email}",
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500
                  )),
                  */
              SizedBox(
                height: 15,
                ),

                Text(
              "Welcome ${sp.name}",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${sp.email}",
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${sp.uid}",
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("PROVIDER:"),
                const SizedBox(
                  width: 5,
                ),
                Text("${sp.provider}".toUpperCase(),
                    style: const TextStyle(color: Colors.red)),
              ],
            ),
            const SizedBox(
              height: 20,
            ),

               Column(
                 children: [
                   ElevatedButton(
                    onPressed: () {
                      sp.userSignOut();
                      nextScreenReplace(context, const LoginScreen());
                    },
                    child: const Text("SIGNOUT",
                        style: TextStyle(
                          color: Colors.white,
                        ))),

                    
                        ElevatedButton(
                    onPressed: () {
                      //sp.userSignOut();
                      nextScreenReplace(context, const principal());
                    },
                    child: const Text("ACCUEIL",
                        style: TextStyle(
                          color: Colors.white,
                        ))),
                 ],
               ),

            ],
          ),
      ),
      ),
    );
  }
  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
