import 'package:auth_bikeapp/model/bike_model.dart';
import 'package:auth_bikeapp/screens/reservation/rental_screen.dart';
import 'package:auth_bikeapp/utils/config.dart';
import 'package:auth_bikeapp/utils/next_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:login_system/screens/location.dart';

class BikeDetailsScreen extends StatefulWidget {
  BikeModel bike;
  BikeDetailsScreen({Key? key, required this.bike}) : super(key: key);

  @override
  State<BikeDetailsScreen> createState() => _BikeDetailsScreenState();
}

class _BikeDetailsScreenState extends State<BikeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    bool _darkMode =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;

    return Scaffold(
        appBar: app_bar(context, "Détails vélo"),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 32, 20, 20),
          child: Stack(children: [
            Card(
              color: _darkMode
                  ? Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5)
                  : Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Hero(
                      tag: widget.bike.bid!,
                      child:
                          // Container(
                          //   height: 230,
                          //   child:
                          Image.network(widget.bike.image!),
                    ),
                    // Image.asset(
                    //   Config.app_icon,
                    //   width: MediaQuery.of(context).size.width,
                    //   height: 250,
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        buildFlexible("${widget.bike.range!} mil"),
                        buildFlexible("${widget.bike.speed!} Km/h"),
                        buildFlexible("${widget.bike.rating!}"),
                      ],
                    ),
                    Row(
                      children: [
                        buildFlexible("Range"),
                        buildFlexible("Speed"),
                        buildFlexible("Rating"),
                      ],
                    ),
                    const SizedBox(height: 10),

                    Center(
                      child: Text("${widget.bike.description}"
                          // style: TextStyle(color: Theme.of(context).primaryColor)

                          ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: () {
                            nextScreen(
                                context,
                                RentalScreen(
                                  bike: widget.bike,
                                ));
                          },
                          child: const Text(
                            "LOUER",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0.0,
              child: SizedBox(
                child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Colors.white),
                      ),
                      primary: _darkMode
                          ? Theme.of(context).primaryIconTheme.color
                          : Colors.white,
                      backgroundColor: _darkMode
                          ? Theme.of(context).scaffoldBackgroundColor
                          : kTextColor,
                    ),
                    onPressed: () {},
                    child: Text(
                      "${widget.bike.model}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 22),
                    )),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: SizedBox(
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.white),
                    ),
                    primary: _darkMode
                        ? Theme.of(context).primaryIconTheme.color
                        : Colors.white,
                    backgroundColor: _darkMode
                        ? Theme.of(context).scaffoldBackgroundColor
                        : kTextColor,
                  ),
                  onPressed: () {},
                  child: const Icon(Icons.favorite),
                ),
              ),
            ),
          ]),
        ));
  }
}

Flexible buildFlexible(text) => Flexible(
    flex: 1,
    fit: FlexFit.tight,
    child: Center(
      child: Text(text,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    ));