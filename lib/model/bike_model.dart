enum BikeType { classic, electric }

class BikeModel {
  String? bid;
  String? type;
  String? brand;
  String? model;
  int? speed;
  String? description;
  List? favoris;
  int? range;
  double? rating;
  String? image;
  String? currentStation;

  // BikeModel({this.bid, this.email, this.firstName, this.lastName});
  BikeModel(
      {this.bid,
      this.type,
      this.brand,
      this.model,
      this.speed,
      this.description,
      this.favoris,
      this.range,
      this.rating,
      this.image,
      this.currentStation});

  // receiving data from server
  factory BikeModel.fromMap(map) {
    return BikeModel(
      bid: map['bid'],
      type: map['type'],
      brand: map['brand'],
      model: map['model'],
      speed: map['speed'],
      description: map['description'],
      favoris: map['favoris'],
      range: map['range'],
      rating: map['rating'],
      image: map['image'],
      currentStation: map['currentStation'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'bid': bid,
      'type': type,
      'brand': brand,
      'model': model,
      'speed': speed,
      'description': description,
      'favoris': favoris,
      'range': range,
      'rating': rating,
      'image':image,
      'currentStation': currentStation,
    };
  }
}

List<BikeModel> bikes = [
  BikeModel(
      bid: "1",
      type: "Classique",
      speed: 40,
      description: dummyText,
      image: "assets/bikeAppLogo.png",
      rating: 4.5),
  BikeModel(
      bid: "2",
      type: "Électrique",
      speed: 35,
      description: dummyText,
      image: "assets/bikeAppLogo.png",
      rating: 4.5),
  BikeModel(
      bid: "3",
      type: "Classique",
      speed: 40,
      description: dummyText,
      image: "assets/bikeAppLogo.png",
      rating: 4.5),
  BikeModel(
      bid: "4",
      type: "Classique",
      speed: 40,
      description: dummyText,
      image: "assets/bikeAppLogo.png",
      rating: 4.5),
  BikeModel(
      bid: "5",
      type: "Électrique",
      speed: 40,
      description: dummyText,
      image: "assets/bikeAppLogo.png",
      rating: 4.5),
  BikeModel(
      bid: "6",
      type: "Classique",
      speed: 40,
      description: dummyText,
      image: "assets/bikeAppLogo.png",
      rating: 4.5),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";