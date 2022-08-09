import 'package:flutter/material.dart';
import 'CardWidget.dart';

class veloCards extends StatefulWidget {
  const veloCards({Key? key}) : super(key: key);

  @override
  State<veloCards> createState() => _veloCardsState();
}

class _veloCardsState extends State<veloCards> with SingleTickerProviderStateMixin {
  late TabController _tabController;

   @override
  void initState(){
    _tabController = new TabController(length: 3, vsync: this,initialIndex:0)..addListener(() {

    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
       Column(
        children: [
          Container(
            child: TabBar(
              isScrollable: true,
              indicatorPadding: EdgeInsets.all(10),
              labelPadding: EdgeInsets.only(left:20, right: 20, top: 10, bottom: 10),
              labelColor: Colors.black,

              labelStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              indicator: BoxDecoration(
                color: Color.fromARGB(255, 212, 209, 209),
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
    )
      )
    );
  }
}