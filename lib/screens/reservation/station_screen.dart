import 'package:auth_bikeapp/utils/config.dart';
import 'package:flutter/material.dart';
// import 'package:login_system/screens/location.dart';

class StationScreen extends StatefulWidget {
  const StationScreen({Key? key}) : super(key: key);

  @override
  State<StationScreen> createState() => _StationScreenState();
}

class _StationScreenState extends State<StationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: app_bar(context, "Détails vélo"),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 32, 20, 20),
          child: Card(
            color:Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    Config.app_icon,
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                  ),
                  Row(
                    children: const [
                      Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Center(
                            child: Text("18 mil",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                          )),
                      Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Center(
                            child: Text("35 Km/h",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                          )),
                      Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Center(
                            child: Text("4.8",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                          )),
                    ],
                  ),
                  Row(
                    children: const [
                      Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Center(
                            child: Text("Range",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                          )),
                      Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Center(
                            child: Text("Speed",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                          )),
                      Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Center(
                            child: Text("Rating",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                          )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Center(
                      child: Text(
                    "Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression"
                    // style: TextStyle(color: Theme.of(context).primaryColor)
                  
                  )),
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
                          // nextScreen(context, null);
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
        ));
  }
}