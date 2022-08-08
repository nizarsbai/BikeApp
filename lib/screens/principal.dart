import 'package:auth_bikeapp/screens/navbar.dart';
import 'package:flutter/material.dart';
import 'CardWidget.dart';
class principal extends StatefulWidget {
  const principal({Key? key}) : super(key: key);

  @override
  State<principal> createState() => _principalState();
}

class _principalState extends State<principal> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState(){
    _tabController = new TabController(length: 3, vsync: this,initialIndex:0)..addListener(() {

    });
  }
  Widget build(BuildContext context) {

    return Scaffold(
      
      backgroundColor: Colors.grey[100],
      drawer: NavBar(),
      appBar: AppBar(

        backgroundColor: Colors.blue,
        //leading: IconButton(onPressed: (){}, icon: const Icon(Icons.menu),color: Colors.white,),

        title: Image.asset('assets/bikeWhite.png',width: 80, height: 80,),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(35)
          ),

        ),
      ),

      body: Column(
        children: [
          Container(
            child: TabBar(
              isScrollable: true,
              indicatorPadding: EdgeInsets.all(10),
              labelPadding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
              labelColor: Colors.black,

              labelStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              indicator: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),

              ),
              controller: _tabController,
              tabs: [

                Text('Favoris'),
                Text('Electrique'),
                Text('Classique'),

              ],
            ),
          ),
          Expanded(
            child: TabBarView(

              controller: _tabController,
                children: [
                  CardWidget(),
                  CardWidget(),
                  CardWidget(),
                ]),
          )
        ],

      ),bottomNavigationBar: Container(

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
    elevation: 0,
    backgroundColor: Colors.transparent,
    items: <BottomNavigationBarItem>[
    BottomNavigationBarItem(
    icon: Icon(Icons.favorite), label: ''),
    BottomNavigationBarItem(
    icon: Icon(Icons.calendar_month), label: ''),
      BottomNavigationBarItem(
          icon: Icon(Icons.favorite), label: ''),
    ],
    ),
    )),

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

    );
  }
}
