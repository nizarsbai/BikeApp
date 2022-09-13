import 'package:auth_bikeapp/model/comment.dart';
import 'package:auth_bikeapp/screens/comments/comment_box_widget.dart';
import 'package:auth_bikeapp/screens/comments/comment_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 60, left: 10, right: 10),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('comments').snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if(snapshot.hasData) {
              List comments = [];
              for(var comment in snapshot.data!.docs) {
                comments.add(Comment.fromJson(comment));
              }
              comments.sort(((a, b) => a.date.compareTo(b.date)));
              comments = List.from(comments.reversed);
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => CommentWidget(
                  context: context, 
                  comment: comments[index],
                )
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      bottomSheet: CommentBoxWidget(controller: commentController),
    );
  }
}