import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String id;
  final String? userId;
  final String? userName;
  final String? userPhoto;
  final String comment;
  final DateTime date;
  final int numberOfLikes;
  final bool isReply;
  final List likers;

  Comment({
    required this.id, 
    required this.userId, 
    required this.userName, 
    required this.userPhoto, 
    required this.comment, 
    required this.date,
    required this.numberOfLikes,
    required this.isReply,
    required this.likers,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'userName': userName,
    'userPhoto': userPhoto,
    'comment': comment,
    'date': date,
    'numberOfLikes': numberOfLikes,
    'isReply': isReply,
    'likers': [],
  };

  static Comment fromJson(json) => Comment(
    id: json['id'], 
    userId: json['userId'], 
    userName: json['userName'], 
    userPhoto: json['userPhoto'], 
    comment: json['comment'], 
    date: (json['date'] as Timestamp).toDate(),
    numberOfLikes: json['numberOfLikes'],
    isReply: json['isReply'],
    likers: json['likers'] as List,
  );
}