import 'package:auth_bikeapp/screens/calendar.dart';
import 'package:auth_bikeapp/screens/favorite.dart';
import 'package:auth_bikeapp/screens/home_screen.dart';
import 'package:auth_bikeapp/screens/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final user = FirebaseAuth.instance.currentUser;

  // Bottom navigation bar
  int _currentIndex = 0;
  final screens = [
    const HomeScreen(),
    const Calendar(),
    const Favorite(),
    const Profile()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            //   UserAccountsDrawerHeader(
            //     accountName: Text(user!.displayName!), 
            //     accountEmail: Text(user!.email!),
            //     currentAccountPicture: CircleAvatar(
            //     backgroundImage: NetworkImage(user!.photoURL!),
            // ),
              //),
            ListTile(
              leading: const Icon(Icons.edit),
              trailing: const Icon(Icons.keyboard_arrow_right),
              title: const Text("Edit profile"),
              onTap: () {
                
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              trailing: const Icon(Icons.keyboard_arrow_right),
              title: const Text("Settings"),
              onTap: () {

              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 168, 122, 119),
        title: Image.asset("assets/bikeAppLogo.png", width: 75, height: 75,),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), 
            label: "Home",
            backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month), 
            label: "Calendar",
            backgroundColor: Colors.orange
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite), 
            label: "Favorite",
            backgroundColor: Colors.green
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), 
            label: "Profile",
            backgroundColor: Colors.red
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}