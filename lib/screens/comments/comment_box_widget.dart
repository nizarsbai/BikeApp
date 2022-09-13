
import 'package:auth_bikeapp/model/comment.dart';
import 'package:auth_bikeapp/model/user_model.dart';
import 'package:auth_bikeapp/utils/text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommentBoxWidget extends StatelessWidget {
  TextEditingController controller;
  bool isReply;
  Comment? parentComment;

  CommentBoxWidget({ 
    Key? key, 
    required this.controller, 
    this.isReply = false,
    this.parentComment
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: TextFormFieldWidget(
        validator: (comment) => comment == null ? "Comment cannpot be blank" : null, 
        controller: controller,
        maxLines: 2,
        hintText: "Write a comment",
        suffixIcon: IconButton(
          onPressed: sendComment, 
          icon: const Icon(Icons.send_sharp, size: 35)
        ),
      ),
    );
  }

  Future<void> sendComment() async {
    final docRef = isReply ? FirebaseFirestore.instance.collection('comments').doc(parentComment!.id).collection("replies").doc() : FirebaseFirestore.instance.collection('comments').doc();

    final snapshot = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();

    UserModel currentUser = UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
    Comment comment = Comment(
      id: docRef.id, 
      userId: currentUser.uid, 
      userName: currentUser.name, 
      userPhoto: currentUser.image_url, 
      comment: controller.text.trim(), 
      date: DateTime.now(),
      numberOfLikes: 0,
      isReply: isReply,
      likers: [],
    );
    controller.text = "";
    await docRef.set(comment.toJson());
  }
}