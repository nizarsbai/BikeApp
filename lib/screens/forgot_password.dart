
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auth_bikeapp/screens/login_screen.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: _formkey,
          child: ListView(
            
            children: [
              // LOGO
              SizedBox(
                width: 120,
                height: 120,
                child: Image.asset("assets/bikeAppLogo.png"),
              ),

              const Text(
                "Enter the email address associated with your account",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),

              const SizedBox(height: 20,),
        
              TextFormField(
                validator: (email) => email != null && !EmailValidator.validate(email) ? "Enter a valid email" : null,
                controller: emailController,
                textInputAction: TextInputAction.done,
                style: const TextStyle(
                  fontSize: 16
                ),
                decoration: InputDecoration(
                  labelText: "  Email  ",
                  labelStyle: const TextStyle(
                    fontSize: 16
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  prefixIcon: const Icon(Icons.email)
                ),
              ),

              const SizedBox(height: 20,),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    if(!_formkey.currentState!.validate()) {
                      return;
                    }
                    if(await resetPassword(emailController.text.trim(), context))
                    {
                    showDialog(context: context, builder: (context) => AlertDialog(
                      title: const Text("Reset Password"),
                      content: const Text(
                        "Check your email to reset your password and login again!",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      actions: [
                        TextButton(onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                        }, child: const Text("Ok"))
                      ],
                    )); 
                    }                 
                  },
                  child: const Text(
                    "Send",
                    style: TextStyle(
                      fontSize: 20, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<bool> resetPassword(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
          backgroundColor: Colors.red,
        )
      );
      return false;
    }
  }
}