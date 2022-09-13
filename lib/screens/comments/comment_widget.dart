
import 'package:auth_bikeapp/model/comment.dart';
//import 'package:auth_bikeapp/provider/theme_provider.dart';
import 'package:auth_bikeapp/screens/comments/comment_replies.dart';
import 'package:auth_bikeapp/utils/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';



class CommentWidget extends StatefulWidget {
  BuildContext context;
  Comment comment;
  double left;
  bool isReply;
  String? commentId;
  CommentWidget({ 
    Key? key,
    required this.context, 
    required this.comment, 
    this.left = 0, 
    this.isReply = false,
    this.commentId
  }) : super(key: key);

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context){
    bool isDark =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;
    //bool isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    return Padding(
      padding: EdgeInsets.only(left: widget.left, right: 0),
      child: Column(
        children: [
          ListTile(
            horizontalTitleGap: 5,
            contentPadding: EdgeInsets.zero,
            leading: Container(
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(widget.comment.userPhoto!)
                )
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: textWidget(
                          widget.comment.userName,
                          //isDark ? ThemeConfig.darkTheme.primaryColor : ThemeConfig.lightTheme.primaryColor
                        )
                      ),
                      textWidget(
                        widget.comment.comment, 
                        //isDark ? ThemeConfig.darkTheme.primaryColor : ThemeConfig.lightTheme.primaryColor
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Row(
              children: [
                textWidget(calculateDate(widget.comment.date)),
                TextButton(
                  onPressed: likeComment, 
                  child: textWidget(
                    "Like", 
                    widget.comment.likers.contains(FirebaseAuth.instance.currentUser!.uid) ? Colors.blue : Colors.grey
                  )
                ),
                textWidget("${widget.comment.numberOfLikes}"),
                TextButton(onPressed: () {
                  if(widget.isReply) return;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CommentRepliesScreen(comment: widget.comment)));
                }, child: textWidget("Reply", Colors.grey)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> likeComment() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final docRef = widget.comment.isReply ? FirebaseFirestore.instance.collection('comments').doc(widget.commentId).collection("replies").doc(widget.comment.id) : FirebaseFirestore.instance.collection('comments').doc(widget.comment.id);

    if(widget.comment.likers.contains(userId)) {
      widget.comment.likers.remove(userId);
      await docRef.update({
        'numberOfLikes': widget.comment.numberOfLikes - 1,
        'likers': widget.comment.likers
      });
    } else {
      await docRef.update({
        'numberOfLikes': widget.comment.numberOfLikes + 1,
        'likers': [...widget.comment.likers, userId]
      });
    }
  }
}

Widget textWidget(text, [color, double? size = 16.0]) => Text(
  text, 
  style: GoogleFonts.varelaRound(
    textStyle: TextStyle(
      fontSize: size!.toDouble(),
      fontWeight: FontWeight.w600,
      color: color
    )
  )
);

String calculateDate(DateTime date) {
  final today = DateTime.now();
  final def = today.difference(date);
  if(def.inSeconds < 60) {
    return "Now";
  } else if(def.inMinutes < 60) {
    return "${def.inMinutes} min";
  } if(def.inHours < 24) {
    return "${def.inHours} h";
  } else if(def.inDays < 7) {
    return "${def.inDays} d";
  } else if(def.inDays >= 7) {
    return "${def.inDays ~/ 7} w";
  } else if(def.inDays > 365) {
    return "${def.inDays ~/ 365} y";
  }
  return "";
}