import 'dart:io';

import 'package:auth_bikeapp/model/user_model.dart';
import 'package:auth_bikeapp/provider/sign_in_provider.dart';
import 'package:auth_bikeapp/utils/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool _obscureText = true;
  User? user;
  final _auth = FirebaseAuth.instance;
  // our form key
  final _formKey = GlobalKey<FormState>();
  //editing Controller
  final nameEditingController = new TextEditingController();
  // final secondNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  bool _isLoading = false;

  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
    emailEditingController.text = "${sp.email}";
    nameEditingController.text = "${sp.name}";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    bool _darkMode =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;
    final sp = context.watch<SignInProvider>();
    //name field
    final nameField = TextFormField(
        autofocus: false,
        controller: nameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Veuillez saisir votre Nom ");
          }
          if (!regex.hasMatch(value)) {
            return ("Veuillez saisir un Nom valide (Min. 3 caractères) ");
          }
          return null;
        },
        onSaved: (value) {
          nameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          // prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          // hintText: "Nom",
          labelText: 'Nom',
          labelStyle: TextStyle(color: Colors.blueAccent),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    //email field
    final emailField = TextFormField(
        enabled: false,
        autofocus: false,
        controller: emailEditingController,
        // style: TextStyle(fontSize: 14),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Veuillez saisir votre e-mail !");
          }
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Veuillez saisir un email valide ! ");
          }
          return null;
        },
        onSaved: (value) {
          emailEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          // prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          //hintText: ,
          //hintStyle: TextStyle(fontSize: 10),
          labelText: 'Email',
          labelStyle: TextStyle(color: Colors.blueAccent),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    // save button
    final saveButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Theme.of(context).iconTheme.color,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () async {
            user = _auth.currentUser!;
            final docUser =
                FirebaseFirestore.instance.collection('users').doc(user!.uid);
            docUser.update({'name': nameEditingController.text});
            await user?.reload();
            user = await _auth.currentUser!;
          },
          child: Text(
            "Enregistrer",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5),
          )),
    );
    // saveProfilePicture() async {
    //   _formKey.currentState.save();
    //   if (_formKey.currentState.validate() && !_isLoading) {
    //     setState(() {
    //       _isLoading = true;
    //     });
    //     String profilePictureUrl = '';
    //     String coverPictureUrl = '';
    //     if (_profileImage == null) {
    //       profilePictureUrl = widget.user.profilePicture;
    //     } else {
    //       profilePictureUrl = await StorageService.uploadProfilePicture(
    //           widget.user.profilePicture, _profileImage);
    //     }
    //     if (_coverImage == null) {
    //       coverPictureUrl = widget.user.coverImage;
    //     } else {
    //       coverPictureUrl = await StorageService.uploadCoverPicture(
    //           widget.user.coverImage, _coverImage);
    //     }
    //     UserModel user = UserModel(
    //       id: widget.user.id,
    //       name: _name,
    //       profilePicture: profilePictureUrl,
    //       bio: _bio,
    //       coverImage: coverPictureUrl,
    //     );

    //     DatabaseServices.updateUserData(user);
    //     Navigator.pop(context);
    //   }
    // }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: app_bar(context, "Modifier mon profil"),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(36),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              children: [
                SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage("${sp.image_url}"),
                      ),
                      Positioned(
                        right: -16,
                        bottom: 0,
                        child: SizedBox(
                          height: 46,
                          width: 46,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: BorderSide(color: Colors.white),
                              ),
                              primary: Theme.of(context).primaryColor,
                              backgroundColor: Colors.grey[200],
                            ),
                            onPressed: () {
                              // saveProfilePicture();
                            },
                            child: Icon(Icons.edit,color: Colors.black,),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 35),
                nameField,
                SizedBox(height: 25),
                emailField,
                SizedBox(height: 30),
                saveButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}