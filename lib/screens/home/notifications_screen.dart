import 'package:auth_bikeapp/screens/navbar.dart';
import 'package:flutter/material.dart';

import '../../utils/config.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: NavBar(),
      appBar: app_bar(context, "Notifications"),
      body: const Text("Aucune Notification", style: TextStyle(
                      fontSize: 18,
                      height: 2,
                      //fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),),
                  
      
    );
  }
}