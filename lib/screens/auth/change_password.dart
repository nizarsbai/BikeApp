import 'dart:ui';

import 'package:auth_bikeapp/utils/config.dart';
import 'package:auth_bikeapp/utils/snack_bar.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  bool _obscureText = true;
  final user = FirebaseAuth.instance.currentUser;
  final _formkey = GlobalKey<FormState>();
  changePassword(String np) async {
    try {
      await user!.updatePassword(np);
      openSnackbar(context, "Mot de passe mis à jour", Colors.white);
    } catch (error) {
      openSnackbar(context, error.toString(), Colors.white54);
    }
  }

  @override
  Widget build(BuildContext context) {
    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: _obscureText,
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Mot de passe est obligatoire !");
          }
          if (!regex.hasMatch(value)) {
            return ("Veuillez saisir un mot de passe valide (Min. 6 caractères) ");
          }
        },
        onSaved: (value) {
          passwordEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Nouveau mot de passe",
          hintStyle: const TextStyle(fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //confirm password field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: _obscureText,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Ces mots de passe ne correspondent pas. Veuillez réessayer.";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirmer le mot de passe",
          hintStyle: const TextStyle(fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final saveButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Theme.of(context).colorScheme.primary,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            changePassword(passwordEditingController.text);
            Navigator.of(context).pop();
          },
          child: const Text(
            "Mettre à jour",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    return Scaffold(
      appBar: app_bar(context, "Changer le mot de passe"),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: _formkey,
          child: ListView(children: [
            passwordField,
            const SizedBox(
              height: 20,
            ),
            confirmPasswordField,
            const SizedBox(
              height: 20,
            ),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).colorScheme.primary,
              child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      changePassword(passwordEditingController.text);
                      openSnackbar(
                          context,
                          "Mot de passe mis à jour avec succès !",
                          Colors.white);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text(
                    "Mettre à jour",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ]),
        ),
      ),
    );
  }

  Future<bool> resetPassword(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message.toString()),
        backgroundColor: Colors.red,
      ));
      return false;
    }
  }
}