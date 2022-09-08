import 'package:flutter/material.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  const Text("Mes Favoris", style: TextStyle(
                      fontSize: 18,
                      height: 2,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),),
              
    );
  }
}