import 'package:auth_bikeapp/main.dart';
import 'package:auth_bikeapp/screens/forgot_password.dart';
import 'package:auth_bikeapp/screens/home_screen.dart';
import 'package:auth_bikeapp/screens/myApp.dart';
import 'package:auth_bikeapp/screens/registration_screen.dart';
import 'package:auth_bikeapp/utils/next_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../provider/internet_provider.dart';
import '../provider/sign_in_provider.dart';
import '../utils/snack_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
   final RoundedLoadingButtonController googleController =
       RoundedLoadingButtonController();
   final RoundedLoadingButtonController facebookController =
       RoundedLoadingButtonController();
  // final RoundedLoadingButtonController twitterController =
  //     RoundedLoadingButtonController();
  // final RoundedLoadingButtonController phoneController =
  //     RoundedLoadingButtonController();

  bool _obscureText=true;
  // form key
  final _formKey = GlobalKey<FormState>();

  //editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user =_googleSignIn.currentUser;

    //email field
    final emailField=TextFormField(
      autofocus: false,
      controller: emailController,
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
          emailController.text=value!;
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
      controller: passwordController,
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
        passwordController.text=value!;
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
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        ));


    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,

        onPressed: () {
          signIn(emailController.text, passwordController.text);
          
        },
        child: Text("Login", textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, color: Colors.white,
        fontWeight: FontWeight.bold),
        )),
    );

  

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
              height: 200,
              child: Image.asset(
                  "assets/bikeAppLogo.png",
                  fit: BoxFit.contain,
              )),
              SizedBox(height: 45),
              emailField,
              SizedBox(height: 25),
              passwordField,
              SizedBox(height: 35),
              loginButton,

              SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Vous n'avez pas de compte? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context)=>
                                  RegistrationScreen()));
                    },
                    

                    child: Text(
                      "S'enregistrer",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  )
                ]),

                Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  // Button facebook
                  Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 const SizedBox(
                  height: 10,
                 ),
                 //facebook login button
                 RoundedLoadingButton(
                   onPressed: () {
                     handleFacebookAuth();
                   },
                   controller: facebookController,
                   successColor: Colors.blue,
                   width: MediaQuery.of(context).size.width * 0.80,
                   elevation: 0,
                   borderRadius: 25,
                   color: Colors.blue,
                   child: Wrap(
                     children: const [
                      Icon(
                       FontAwesomeIcons.facebook,
                         size: 20,
                         color: Colors.white,
                       ),
                       SizedBox(
                         width: 15,
                       ),
                       Text("Sign in with Facebook",
                           style: TextStyle(
                               color: Colors.white,
                               fontSize: 15,
                              fontWeight: FontWeight.w500)),
                     ],
                      ),
                 ),
                 const SizedBox(
                   height: 10,
                 ),

                
               ],
               ),


                  TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()));
                  }, child: const Text("Forgot password?")),
                ],
              ),

              

              SizedBox(height: 15),
              
              Text("OR", textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.grey,
                fontWeight: FontWeight.bold)),
              
              SizedBox(height: 15),
                

                SignInButton(Buttons.Google, onPressed: () async {
                  await _googleSignIn.signIn();
                  
                  
                if(user != null) {
                  // ignore: use_build_context_synchronously
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                }
              setState(() {});

            }),
            SignInButton(Buttons.Facebook, onPressed: (){
              //handleFacebookAuth();
              
            }),
            
            SignInButton(Buttons.Apple, onPressed: () {

            }),

            ],
          ),
        ),
        ),

        
      ),
      )

          
        
    );
    
  }

  //handling Facebookauth
   Future handleFacebookAuth() async {
     final sp = context.read<SignInProvider>();
     final ip = context.read<InternetProvider>();
     await ip.checkInternetConnection();

     if (ip.hasInternet == false) {
      openSnackbar(context, "Check your Internet connection", Colors.red);
       //facebookController.reset();
     } else {
       await sp.signInWithFacebook().then((value) {
         if (sp.hasError == true) {
           openSnackbar(context, sp.errorCode.toString(), Colors.red);
           facebookController.reset();
         } else {
          // checking whether user exists or not
          sp.checkUserExists().then((value) async {
           if (value == true) {
               // user exists
               await sp.getUserDataFromFirestore(sp.uid).then((value) => sp
                   .saveDataToSharedPreferences()
                   .then((value) => sp.setSignIn().then((value) {
                         //facebookController.success();
                        handleAfterSignIn();
                       })));
             } else {
               // user does not exist
               sp.saveDataToFirestore().then((value) => sp
                   .saveDataToSharedPreferences()
                   .then((value) => sp.setSignIn().then((value) {
                        //facebookController.success();
                         handleAfterSignIn();
                       })));
             }
           });
         }
       });
     }
   }

  // handle after signin
  handleAfterSignIn() {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      nextScreenReplace(context, const HomeScreen());
    });
  }

  // login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MainPage())),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}
