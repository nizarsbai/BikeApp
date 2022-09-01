import 'package:auth_bikeapp/provider/internet_provider.dart';
import 'package:auth_bikeapp/provider/sign_in_provider.dart';
// import 'package:auth_bikeapp/screens/login_screen.dart';
import 'package:auth_bikeapp/screens/splash_screen.dart';
import 'package:auth_bikeapp/utils/config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'BikeApp : Bike Rental',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: const LoginScreen(),
    // );

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: ((context) => SignInProvider()),
          ),
          ChangeNotifierProvider(
            create: ((context) => InternetProvider()),
          ),
          ChangeNotifierProvider(
            create: ((context) => ThemeProvider()),
          ),
        ],
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            // restorationScopeId: "root",
            themeMode: themeProvider.themeMode,
            theme: Config.lightTheme,
            darkTheme: Config.darkTheme,
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        }
        // child: MaterialApp(
        //   themeMode: themeProvider.themeMode,
        //   theme: Config.lightTheme,
        //   darkTheme: Config.darkTheme,
        //   home: SplashScreen(),
        //   debugShowCheckedModeBanner: false,
        // ),
        );
  }
}