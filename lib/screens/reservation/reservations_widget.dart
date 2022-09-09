import 'package:auth_bikeapp/model/reservation_model.dart';
import 'package:auth_bikeapp/screens/reservation/reservation_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget buildReservationsWidget(String str) => StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance.collection('reservations').snapshots(),
  builder: (context, snapshot) {
    if(snapshot.hasError) {
      return const Center(
        child: Text("Something was wrong"),
      );
    } else if(snapshot.hasData) {
      final reservations = [];
      for(var reservation in snapshot.data!.docs) {
        reservations.add(Reservation.fromJson(reservation.data()));
      }
      return Container(
        color: const Color.fromRGBO(58, 66, 86, 1.0),
        child: ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) => buildReservationWidget(context, reservations[index], str)
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
);