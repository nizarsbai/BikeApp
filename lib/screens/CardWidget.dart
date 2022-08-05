import 'package:flutter/material.dart';
class CardWidget extends StatelessWidget {
  const CardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        itemCount: 6,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),

        itemBuilder: (context,index){
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60)
            ),
            child: Column(
              children: [
                Image.asset('assets/bikeAppLogo.png',width: 150,height: 120,),
                Text('VTT ST 50',style: TextStyle(),),
                Text('40\$ - 1km')
              ],
            ),

          );
        },
      ),
    );
  }
}
