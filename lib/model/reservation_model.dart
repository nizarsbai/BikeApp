
class Reservation {
  final String id;
  final String idUser;
  final String starting;
  final String destination;
  final DateTime date;
  final String duration;
  final double price;

  Reservation({
    required this.id, 
    required this.idUser , 
    required this.starting, 
    required this.destination, 
    required this.date, 
    required this.duration, 
    required this.price
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "idUser": idUser,
    "starting": starting,
    "destination": destination,
    "date": date,
    "duration": duration,
    "price": price,
  };
}