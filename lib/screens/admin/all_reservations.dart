import 'package:auth_bikeapp/screens/reservation/reservations_widget.dart';
import 'package:auth_bikeapp/screens/seach_delegate.dart';
import 'package:flutter/material.dart';

class AllReservationsScreen extends StatefulWidget {
  const AllReservationsScreen({ Key? key }) : super(key: key);

  @override
  State createState() => _AllReservationsScreenState();
}

class _AllReservationsScreenState extends State<AllReservationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reservations"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            showSearch(context: context, delegate: CustomSearchDelegate(source: 'reservations'));
          }, icon: const Icon(Icons.search))
        ],
      ),
      body: buildReservationsWidget('')
    );
  }
}