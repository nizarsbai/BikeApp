import 'package:auth_bikeapp/model/reservation_model.dart';
import 'package:intl/intl.dart';
import 'package:auth_bikeapp/model/user_model.dart';
import 'package:auth_bikeapp/screens/reservation/reservation_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget buildReservationWidget(context, Reservation reservation, String str) { 
  return 
  reservation.userName.toLowerCase().contains(str.toLowerCase()) ?
  Container(
    decoration: const BoxDecoration(
      color: Color.fromRGBO(64, 75, 96, .9),
      border: Border(bottom: BorderSide(width: 2, color: Colors.white30)),
    ),
    child: ListTile(
      title: builTextWidget(reservation.userName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          builTextWidget(DateFormat('dd/MM/yyyy hh:mm').format(reservation.date)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              builTextWidget(reservation.starting),
              builTextWidget("Duration: ${reservation.duration} H", 18, Colors.green),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              builTextWidget(reservation.destination),
              builTextWidget("Price: ${reservation.price} DH", 18, Colors.green),
            ],
          )
        ],
      ),
      onTap: () async {
        final snapshot = await FirebaseFirestore.instance.collection('users').doc(reservation.idUser).get();
        UserModel user = UserModel.fromMap(snapshot.data()!);
        // ignore: use_build_context_synchronously
        Navigator.push(context, MaterialPageRoute(builder: (context) => ReservationDetailsScreen(user: user, reservation: reservation)));
      },
    )
  ) : Container();
}

Widget builTextWidget(text, [double? size = 20, color = Colors.white]) => Text("$text", style: TextStyle(
  fontSize: size,
  fontWeight: FontWeight.bold,
  color: color
),);