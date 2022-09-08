import 'package:auth_bikeapp/model/bike_model.dart';
import 'package:auth_bikeapp/screens/reservation/bikedetails_screen.dart';
import 'package:auth_bikeapp/utils/config.dart';
import 'package:auth_bikeapp/utils/next_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _darkMode =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: StreamBuilder(
        stream: readBikes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Text("Something was wrong");
          } else if (snapshot.hasData) {
            List bikes = snapshot.data as List<Map<String, dynamic>>;
            return GridView.builder(
              itemCount: bikes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Stack(//alignment: AlignmentDirectional.center,
                    children: <Widget>[
                  GestureDetector(
                    onTap: () => nextScreen(
                        context,
                        BikeDetailsScreen(
                            bike: BikeModel.fromMap(bikes[index]))),
                    child: Card(
                      // shadowColor: Colors.black,
                      color: Provider.of<ThemeProvider>(context).themeMode ==
                              ThemeMode.dark
                          ? Theme.of(context).primaryIconTheme.color
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 4,
                          ),
                          Hero(
                            tag: bikes[index]['bid'],
                            child: Image.network(
                              bikes[index]['image'],
                              width: 160,
                              height: 110,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          Text(
                            "${bikes[index]['brand']}",
                            style: TextStyle(
                                color: _darkMode
                                    ? Theme.of(context).scaffoldBackgroundColor
                                    : Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text("${bikes[index]['speed']} Km/h",
                              style: TextStyle(
                                color: _darkMode
                                    ? Theme.of(context).scaffoldBackgroundColor
                                    : Colors.black,
                              )),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0.0,
                    child: SizedBox(
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                                color: _darkMode ? Colors.white : kTextColor),
                          ),
                          primary: _darkMode
                              ? Theme.of(context).primaryIconTheme.color
                              : Colors.white,
                          backgroundColor: _darkMode
                              ? Theme.of(context).scaffoldBackgroundColor
                              : kTextColor,
                        ),
                        onPressed: () {},
                        child: Row(children: [
                          const Icon(
                            Icons.star,
                            size: 17,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            "${bikes[index]['rating']}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 14),
                          )
                        ]),
                      ),
                    ),
                  ),
                ]);
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

Stream<List<Map<String, dynamic>>> readBikes() => FirebaseFirestore.instance
    .collection('bikes')
    .snapshots()
    .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());