import 'package:auth_bikeapp/model/bike_model.dart';
import 'package:auth_bikeapp/model/reservation_model.dart';
import 'package:auth_bikeapp/screens/reservation/confirmation_screen.dart';
import 'package:auth_bikeapp/utils/config.dart';
import 'package:auth_bikeapp/utils/next_screen.dart';
import 'package:auth_bikeapp/utils/snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RentalScreen extends StatefulWidget {
  BikeModel bike;
  RentalScreen({Key? key, required this.bike}) : super(key: key);

  @override
  State<RentalScreen> createState() => _RentalScreenState();
}

class _RentalScreenState extends State<RentalScreen> {
  TextEditingController numberOfHoursController = TextEditingController();
  String? starting;
  String? destination;
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  double price = 0;
  String duration = "1h30min";

  bool reserve = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar(context, "Confirmer votre réservation"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(children: [
            Hero(
              tag: "bike",
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(widget.bike.image!))),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Départ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                    alignment: Alignment.centerRight,
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    height: 40,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: Text(
                      widget.bike.currentStation!,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Destination",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 15,
                ),
                Container(
                  // width: MediaQuery.of(context).size.width / 2 - 20,
                  // height: 40,
                  width: 200,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: StreamBuilder(
                    stream: readStationsNames(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return const Text("Something was wrong");
                      } else if (snapshot.hasData) {
                        List stations = snapshot.data as List;
                        return DropdownButtonHideUnderline(
                          child: DropdownButton(
                              itemHeight: null,
                              isExpanded: true,
                              value: destination,
                              items: stations
                                  .map((station) => DropdownMenuItem(
                                      value: station,
                                      //station.toString() !=
                                      //         widget.bike.currentStation!
                                      //     ? station
                                      //     : null,
                                      child: Text(station)))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  destination = "$value";
                                });
                              }),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Date",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                    alignment: Alignment.centerRight,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: Row(
                      children: [
                        Text(
                            "${date.year}/${date.month}/${date.day} ${time.hour}:${time.minute}"),
                        IconButton(
                          onPressed: () async {
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: date,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2025));

                            if (newDate == null) return;
                            setState(() {
                              date = newDate;
                            });

                            TimeOfDay? newTime = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());

                            if (newTime == null) return;
                            setState(() {
                              time = newTime;
                            });
                          },
                          icon: const Icon(Icons.calendar_month),
                        ),
                      ],
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Durée estimée",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: 120,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 0
                  ),
                  child: TextField(
                    controller: numberOfHoursController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Hours",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    onChanged: (value) {
                      if(value != "") {
                        setState(() {
                          price = double.parse(value) * 15;
                        });
                      } else {
                        setState(() {
                          price = 0.0;
                        });
                      }
                    },
                  ),
                ),
            
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Prix",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                    alignment: Alignment.centerRight,
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    height: 40,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: Text(
                      "$price DH",
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            reserve
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        if(destination==null)
                        {
                         Fluttertoast.showToast(msg: "Veuillez choisir une destination");
                         return;
                          //print(error.code);
                        }
                        // if(duration==null)
                        // {
                        //   Fluttertoast.showToast(msg: "Veuillez choisir une durée");
                        //  return;
                        // }
                        setState(() {
                          starting = widget.bike.currentStation!;
                          reserve = true;
                        });

                        final reservationRef = FirebaseFirestore.instance
                            .collection('reservations')
                            .doc();
                            
                      final snap = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
                      final userName = snap.data()!['name'];

                      //print(userName);
                        Reservation reservation = Reservation(
                          id: reservationRef.id,
                          idUser: FirebaseAuth.instance.currentUser!.uid,
                          starting: starting!,
                          destination: destination!,
                          userName: userName!,
                          date: DateTime(date.year, date.month, date.day,
                              time.hour, time.minute),
                          duration: double.parse(numberOfHoursController.text.trim()),
                          price: price,
                        );

                        await reservationRef.set(reservation.toJson());

                        setState(() {
                          reserve = false;
                        });
                        nextScreen(context, ConfirmationScreen());
                      },
                      child: const Text(
                        "Réserver",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
          ]),
        ),
      ),
    );
  }

  Stream<List<dynamic>> readStationsNames() => FirebaseFirestore.instance
      .collection('stations')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => doc.data()['address']).toList());
}