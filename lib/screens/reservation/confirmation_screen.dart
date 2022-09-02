import 'package:auth_bikeapp/screens/principal.dart';
import 'package:auth_bikeapp/utils/config.dart';
import 'package:flutter/material.dart';

import '../../utils/next_screen.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar(context, "Réservation Complète"),
      
      body: Center(
        
        child: Column(
          
          children: [
            SizedBox(height: 15),
            const Text(
                "Votre réservation est complète. Vous pouvez maintenant récupérer votre vélo", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                const Text("  "),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  nextScreen(context, const principal());
                },
                child: const Text(
                  "Retourner à la page d'accueil",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}