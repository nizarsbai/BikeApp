import 'package:auth_bikeapp/model/comment.dart';
import 'package:auth_bikeapp/screens/comments/comment_box_widget.dart';
import 'package:auth_bikeapp/screens/comments/comment_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentRepliesScreen extends StatefulWidget {
  Comment comment;
  CommentRepliesScreen({Key? key, required this.comment}) : super(key: key);

  @override
  State<CommentRepliesScreen> createState() => _CommentRepliesScreenState();
}

class _CommentRepliesScreenState extends State<CommentRepliesScreen> {
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWidget("Replies"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 60, left: 10, right: 10),
        child: ListView(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('comments').doc(widget.comment.id).snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasError) {
                  return const Text("Something was wrong");
                } else if(snapshot.hasData) {
                  Comment comment = Comment.fromJson(snapshot.data);
                  return CommentWidget(
                    context: context, 
                    comment: comment,
                    isReply: true,
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }, 
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('comments').doc(widget.comment.id).collection('replies').snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if(snapshot.hasData) {
                  List comments = [];
                  for(var comment in snapshot.data!.docs) {
                    comments.add(Comment.fromJson(comment));
                  }
                  comments.sort(((a, b) => a.date.compareTo(b.date)));
                  return ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) => CommentWidget(
                      context: context, 
                      comment: comments[index],
                      isReply: true,
                      commentId: widget.comment.id,
                      left: 40,
                    )
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
      bottomSheet: CommentBoxWidget(controller: commentController, isReply: true, parentComment: widget.comment,),
    );
  }
}