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
      body:  Center(
                  child: ListTile(
                    leading: const Icon(Icons.help, size: 30, color: Color.fromARGB(255, 10, 56, 94),),
                    title: const Text("Mes Favoris", style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),),
                  )
      )
              
    );
  }
}