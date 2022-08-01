import 'dart:math';

import 'package:auth_bikeapp/model/user_model.dart';
import 'package:auth_bikeapp/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  
  bool _obscureText=true;

  final _auth = FirebaseAuth.instance;
  // our form key
  final _formKey=GlobalKey<FormState>();
  //editing Controller
  final firstNameEditingController=new TextEditingController();
  final secondNameEditingController=new TextEditingController();
  final emailEditingController=new TextEditingController();
  final passwordEditingController=new TextEditingController();
  final confirmPasswordEditingController=new TextEditingController();


  @override
  Widget build(BuildContext context) {
    //first name field
    final firstNameField=TextFormField(
        autofocus: false,
        controller: firstNameEditingController,
        keyboardType: TextInputType.name,
        
      validator: (value){
        RegExp regex = new RegExp(r'^.{3,}$');
        if(value!.isEmpty) {
          return ("Veuillez saisir votre Nom ");
        }
        if(!regex.hasMatch(value)){
          return("Veuillez saisir un Nom valide (Min. 3 caractères) ");
        }
        return null;
      },

        onSaved: (value)
        {
          firstNameEditingController.text=value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Nom",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //second name field
    final secondNameField=TextFormField(
        autofocus: false,
        controller: secondNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value){
        RegExp regex = new RegExp(r'^.{3,}$');
        if(value!.isEmpty) {
          return ("Veuillez saisir votre Prénom ");
        }
        if(!regex.hasMatch(value)){
          return("Veuillez saisir un prénom valide (Min. 3 caractères) ");
        }
      },
        onSaved: (value)
        {
          secondNameEditingController.text=value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Prenom",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //email field
    final emailField=TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value)
      {
        if(value!.isEmpty)
        {
          return("Veuillez saisir votre e-mail !");
        }
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value))
        {
          return ("Veuillez saisir un email valid ! ");
        }
        return null;
      },
        onSaved: (value)
        {
          emailEditingController.text=value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField=TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: _obscureText,
        validator: (value){
        RegExp regex = new RegExp(r'^.{6,}$');
        if(value!.isEmpty) {
          return ("Mot de passe est obligatoire !");
        }
        if(!regex.hasMatch(value)){
          return("Veuillez saisir un mot de passe valide (Min. 6 caractères) ");
        }
      },
        onSaved: (value)
        {
          firstNameEditingController.text=value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          suffixIcon: GestureDetector(
              onTap: (){
                setState(() {
                  _obscureText=!_obscureText;
                });
            },
            child: Icon(_obscureText
             ? Icons.visibility
             : Icons.visibility_off),
             ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Mot de passe",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //confirm password field
    final confirmPasswordField=TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: _obscureText,

        validator: (value)
        {
          if(confirmPasswordEditingController.text !=
           passwordEditingController.text)
          {
            return "Ces mots de passe ne correspondent pas. Veuillez réessayer.";
          }
          return null;
        } ,
        onSaved: (value)
        {
          confirmPasswordEditingController.text=value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          suffixIcon: GestureDetector(
              onTap: (){
                setState(() {
                  _obscureText=!_obscureText;
                });
            },
            child: Icon(_obscureText
             ? Icons.visibility
             : Icons.visibility_off),
             ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirmer le mot de passe",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    // sign up button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,

          onPressed: () /*async*/ {
            signUp(emailEditingController.text, passwordEditingController.text);
            /*final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
                  await googleSignIn.signOut();
                  await FirebaseAuth.instance.signOut();
                  */
          },
          child: Text("S'enregistrer", textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.white,
                fontWeight: FontWeight.bold),
          )),
    );


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blueAccent),
          onPressed: (){
            //passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child:Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 180,
                        child: Image.asset(
                          "assets/bikeAppLogo.png",
                          fit: BoxFit.contain,
                        )),
                    SizedBox(height: 45),
                    firstNameField,
                    SizedBox(height: 20),
                    secondNameField,
                    SizedBox(height: 20),
                    emailField,
                    SizedBox(height: 20),
                    passwordField,
                    SizedBox(height: 20),
                    confirmPasswordField,
                    SizedBox(height: 20),
                    signUpButton,




                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async
  {
    if(_formKey.currentState!.validate())
    {
        await _auth.createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {
          postDetailsToFirestore()
          
        }).catchError((e)
        {
          Fluttertoast.showToast(msg: e!.message);
        });
    }
  }

  postDetailsToFirestore() async{
    //calling our firestore
    //calling our user model
    //sending these values

    FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel=UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.lastName = secondNameEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Compte créé avec succès. :) ");

     Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);

  }
}
