import 'package:auth_bikeapp/model/reservation_model.dart';
import 'package:auth_bikeapp/model/user_model.dart';
import 'package:flutter/material.dart';

class ReservationDetailsScreen extends StatefulWidget {
  UserModel user;
  Reservation reservation;
  ReservationDetailsScreen({ Key? key, required this.user, required this.reservation }) : super(key: key);

  @override
  State createState() => _ReservationDetailsScreenState();
}

class _ReservationDetailsScreenState extends State<ReservationDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reservation details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Text("User Informations :", style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),),
            buildItem(item: "Name : ", value: widget.user.name),
            //buildItem(item: "CIN : ", value: widget.user.cin),
            //buildItem(item: "Date de naissance : ", value: widget.user.cin),
            buildItem(item: "Email : ", value: widget.user.email),
            //buildItem(item: "Phone : ", value: widget.user.phone),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text("Reservation :", style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),),
            ),
            buildItem(item: "Starting Station :", value: widget.reservation.starting),
            buildItem(item: "Destination : ", value: widget.reservation.destination),
            buildItem(item: "Duration : ", value: "${widget.reservation.duration} Hours"),
            buildItem(item: "Prix : ", value: "${widget.reservation.price} DH"),
            buildItem(item: "State : ", value: "Not payed"),
          ],
        ),
      )
    );
  }

  Widget buildItem({required item, required value}) => Padding(
    padding: const EdgeInsets.only(top: 10, left: 10),
    child: Row(
      children: [
        Text(item, style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),),
        Text(value, style: const TextStyle(
          fontSize: 18,
        ),)
      ],
    ),
  );
}