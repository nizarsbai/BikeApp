import 'package:flutter/material.dart';
import '../utils/config.dart';
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
          Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Text(
                  "Choisir votre vélo",
                  style: TextStyle(
                    color: kTextColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 23,
                  ),
                ),
              ),
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

                Text('Favoris', style: TextStyle(fontFamily: 'Varela_Round')),
                Text('Electrique',style: TextStyle(fontFamily: 'Varela_Round')),
                Text('Classique',style: TextStyle(fontFamily: 'Varela_Round')),

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