class UserModel {
  String? uid;
  String? email;
  String? name;
  String? image_url;
  String? provider;

  UserModel({this.uid, this.email, this.name, this.image_url, this.provider});

  // receiving data from server
  factory UserModel.fromMap(map){
    return UserModel(
      // uid: map['uid'],
      // email: map['email'],
      // firstName: map['firstName'],
      // lastName: map['lastName'],
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      image_url: map['image_url'],
      provider: map['provider'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      // 'uid':uid,
      // 'email':email,
      // 'firstName':firstName,
      // 'lastName':lastName,
      'uid': uid,
      'email': email,
      'name': name,
      'image_url': image_url,
      'provider': provider,
    };
  }

}