import 'package:auth_bikeapp/screens/admin/all_reservations.dart';
import 'package:auth_bikeapp/screens/comments/comments.dart';
import 'package:auth_bikeapp/screens/home/notifications_screen.dart';
import 'package:auth_bikeapp/screens/profile/editprofile_screen.dart';
import 'package:flutter/material.dart';
import 'package:auth_bikeapp/model/user_model.dart';
import 'package:auth_bikeapp/provider/sign_in_provider.dart';
import 'package:auth_bikeapp/utils/next_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../provider/sign_in_provider.dart';
import '../utils/config.dart';
import 'home/parametres_screen.dart';
import 'login_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    bool _darkMode =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;
    return Drawer(
      backgroundColor:
          _darkMode ? Theme.of(context).scaffoldBackgroundColor : Colors.white,
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName:Text("${sp.name}", style: TextStyle(color: Colors.white,fontSize: 20),),
            accountEmail: Text("${sp.email}", style: TextStyle(color: Colors.white),),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  "${sp.image_url}",
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              //color: Colors.blue,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    'https://hdwallpaperim.com/wp-content/uploads/2017/08/24/99743-bicycle-simple_background.jpg'),
              ),
            ),
            onDetailsPressed: () {
              nextScreen(context, EditProfile());
            },
          ),
          
          ListTile(
            leading: Icon(Icons.restore),
            title: Text('Mes Reservations'),
            onTap: () => nextScreen(context,AllReservationsScreen()),
          ),
          ListTile(
            leading: Icon(Icons.comment),
            title: Text('Commentaires'),
            onTap: () => nextScreen(context, CommentsScreen()),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () => nextScreen(context, NotificationsScreen()),
            trailing: ClipOval(
              child: Container(
                color: Colors.red,
                width: 20,
                height: 20,
                child: Center(
                  child: Text(
                    '8',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favoris'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Paramètres'),
            onTap: () => nextScreen(context, ParametresScreen()),
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Policies'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
             title: const Text('Se déconnecter'),
              leading: const Icon(Icons.exit_to_app),
              onTap: () async {
                final action = await AlertDialogs.yesCancelDialog(
                    context, 'Se déconnecter', 'Êtes vous sûr ?');
                if (action == DialogsAction.oui) {
                  sp.userSignOut();
                  nextScreenReplace(context, const LoginScreen());
                  // setState(() => tappedYes = true);
                } else {
                  // setState(() => tappedYes = false);
                }
              }),
        ],
      ),
    );
  }
}