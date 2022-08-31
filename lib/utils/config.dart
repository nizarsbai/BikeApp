import 'package:flutter/material.dart';

class Config {
  static final app_icon = "assets/bikeAppLogo.png";
  static final app_font = "Varela_Round";
  // static final apikey_twitter = "9Feip53jOk8esDtSM6w08d3XT";
  // static final secretkey_twitter =
  //     "1eJOsBMqbI5HGjVAH7KNWkJsGgD44EHMFsZrqb1ne5nfYSwhBW";

  static final darkTheme = ThemeData(
    //backgroundColor: Color(0xff212E52),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xff212E52),
    primaryColor: Colors.black,
    // colorScheme: ColorScheme.fromSeed(
    //     seedColor: Color.fromARGB(255, 8, 34, 50), brightness: Brightness.dark),
    fontFamily: "Varela_Round",
    iconTheme: IconThemeData(color: Colors.white, opacity: 1),
  );

  static final lightTheme = ThemeData(
    //backgroundColor: Colors.blueAccent,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.grey[550],
    primaryColor: Colors.white,
    // colorScheme: ColorScheme.fromSeed(
    //     seedColor: Color.fromRGBO(56, 182, 255, 1),
    //     brightness: Brightness.light,
    //     primary: Colors.blueAccent),
    fontFamily: "Varela_Round",
    iconTheme:
        const IconThemeData(color: Color.fromRGBO(56, 182, 255, 1), opacity: 1),
  );
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;
  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

const kTextColor = Color.fromRGBO(56, 182, 255, 1);
// const kTextColor = Colors.blueAccent;
const kTextLightColor = Color.fromARGB(255, 171, 185, 196);

const kDefaultPaddin = 20.0;

AppBar app_bar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    iconTheme: Theme.of(context).iconTheme,
    elevation: 0,
    title:
        Text(title, style: TextStyle(color: Theme.of(context).iconTheme.color)),
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
  );
}

enum DialogsAction { Oui, Annuler }

class AlertDialogs {
  static Future<DialogsAction> yesCancelDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(DialogsAction.Annuler),
              child: Text(
                'Annuler',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(DialogsAction.Oui),
              child: Text(
                'Confirmer',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor),
              ),
            )
          ],
        );
      },
    );
    return (action != null) ? action : DialogsAction.Annuler;
  }
}