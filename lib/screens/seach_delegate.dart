import 'package:auth_bikeapp/model/user_model.dart';
import 'package:auth_bikeapp/screens/reservation/reservations_widget.dart';
//import 'package:auth_bikeapp/screens/admin/users_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  String? source;
  CustomSearchDelegate({required this.source});

  Stream<List<UserModel>> readUsers() => FirebaseFirestore.instance.collection('users').snapshots().map((snapshot) => snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList());

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () {
        query = '';
      }, icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () {
      close(context, null);
    }, icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    
      return buildReservationsWidget(query);
    
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    
      return buildReservationsWidget(query);
    
  }
}