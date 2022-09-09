
import 'package:cloud_firestore/cloud_firestore.dart';

class Reservation {
  final String id;
  final String idUser;
  final String starting;
  final String destination;
  final String userName;
  final DateTime date;
  final double duration;
  final double price;

  Reservation({
    required this.id, 
    required this.idUser , 
    required this.starting, 
    required this.destination, 
    required this.userName,
    required this.date, 
    required this.duration, 
    required this.price
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "idUser": idUser,
    "starting": starting,
    "destination": destination,
    "userName": userName,
    "date": date,
    "duration": duration,
    "price": price,
  };

  static Reservation fromJson(json) => Reservation(
    id: json['id'], 
    idUser: json['idUser'], 
    userName: json['userName'], 
    starting: json['starting'], 
    destination: json['destination'], 
    date: (json['date'] as Timestamp).toDate(), 
    duration: json['duration'], 
    price: json['price']
  );
}