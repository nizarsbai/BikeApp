class Station {
  final String id;
  final String name;
  final String address;
  final String nbBikes;

  Station({
    required this.id,
    required this.name, 
    required this.address, 
    required this.nbBikes
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "nbBikes": nbBikes
  };
}