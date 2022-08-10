import 'package:auth_bikeapp/model/user_model.dart';
import 'package:auth_bikeapp/provider/sign_in_provider.dart';
import 'package:auth_bikeapp/screens/navbar.dart';
import 'package:auth_bikeapp/screens/profile.dart';
import 'package:auth_bikeapp/screens/veloCards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CardWidget.dart';
import 'map_screen.dart';
import 'favorite.dart';
import 'map_screen.dart';
import 'home_screen.dart';
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
    const Profile()
  ];
  
@override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    return Scaffold(
      
      backgroundColor: Colors.grey[100],
      drawer: NavBar(),
      appBar: AppBar(

        backgroundColor: Color.fromRGBO(56,182,255, 1),
        //leading: IconButton(onPressed: (){}, icon: const Icon(Icons.menu),color: Colors.white,),

        title: Image.asset('assets/bikeWhite.png',width: 80, height: 80,),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(35)
          ),

        ),
      ),

      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
        topRight: Radius.circular(30), topLeft: Radius.circular(30)),
    ),
    
    child: Material(
    elevation: 0.0,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(40.0)),

    child: BottomNavigationBar(
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
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
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
