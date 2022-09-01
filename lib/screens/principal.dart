import 'package:auth_bikeapp/model/user_model.dart';
import 'package:auth_bikeapp/provider/sign_in_provider.dart';
import 'package:auth_bikeapp/screens/admin/addbike_screen.dart';
import 'package:auth_bikeapp/screens/home/notifications_screen.dart';
import 'package:auth_bikeapp/screens/navbar.dart';
import 'package:auth_bikeapp/screens/profile.dart';
import 'package:auth_bikeapp/screens/veloCards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/config.dart';
import '../utils/next_screen.dart';
import 'CardWidget.dart';
import 'map_screen.dart';
import 'favorite.dart';
import 'map_screen.dart';
class principal extends StatefulWidget {
  const principal({Key? key}) : super(key: key);

  @override
  _principalState createState() => _principalState();
}

class _principalState extends State<principal> with SingleTickerProviderStateMixin {
  //late TabController _tabController;
  // Bottom navigation bar
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
  }




  int _currentIndex = 0;
  final screens = [
    const veloCards(),
    const MapScreen(),
    const Favorite(),
    //const AddBikeScreen(),
    const Profile()
  ];
  
@override
  Widget build(BuildContext context) {
    bool _darkMode =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;
    final sp = context.watch<SignInProvider>();
    return Scaffold(
      
      //backgroundColor: Colors.grey[100],
      drawer: const NavBar(),
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        //backgroundColor: Color.fromRGBO(56,182,255, 1),
        //leading: IconButton(onPressed: (){}, icon: const Icon(Icons.menu),color: Colors.white,),

        title: Image.asset('assets/bikeAppLogo.png',width: 80, height: 80,),
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(35)
          ),
          

        ),
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(
                primary: Theme.of(context).iconTheme.color),
            onPressed: () {
              nextScreen(context, const NotificationsScreen());
            },
            icon: const Icon(Icons.notifications),
            label: const Text(''),
          ),
        ],
      ),

      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
        color: kTextColor,
        borderRadius: BorderRadius.only(
        topRight: Radius.circular(30), topLeft: Radius.circular(30)),
    ),
    
    child: Material(
    elevation: 0.0,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(40.0)),

    child: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      selectedItemColor: Theme.of(context).iconTheme.color,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), 
            label: "Home",
            backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map), 
            label: "Stations",
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
        showUnselectedLabels: false,
      ),
    
    //currentIndex: _currentIndex,
    
    //onTap: _onItemTapped,
    
    ),
    ),
    );
  
      /*SafeArea(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: (){},
                    child: Text('Favorite'),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                     // side: BorderSide(width: 2, color: Colors.green),
                      backgroundColor: Colors.white
                    ),
                  ),
                  OutlinedButton(
                    onPressed: (){},
                    child: Text('Electric'),
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        // side: BorderSide(width: 2, color: Colors.green),
                        backgroundColor: Colors.white
                    ),
                  ),
                  OutlinedButton(
                    onPressed: (){},
                    child: Text('Classic'),
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        // side: BorderSide(width: 2, color: Colors.green),
                        backgroundColor: Colors.white
                    ),
                  ),
                ],
              ),
              CardWidget()
            ],

           ),
        ),
      ),*/

    
  }
}
