import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:auth_bikeapp/model/bike_model.dart';

class AddBikeScreen extends StatefulWidget {
  const AddBikeScreen({Key? key}) : super(key: key);

  @override
  State<AddBikeScreen> createState() => _AddBikeScreenState();
}

class _AddBikeScreenState extends State<AddBikeScreen> {
  TextEditingController marqueController = TextEditingController();
  TextEditingController modeleController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController speedController = TextEditingController();
  TextEditingController rangeController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  bool _loading = false;

  String? fileName;
  File? imageFile;
  String? stationName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32, 20, 32, 10),
        child: ListView(
          children: [
            Form(
              key: formkey,
              child: Column(
                children: [
                  imageFile == null ? Image.asset('assets/bikeAppLogo.png') : Image.file(imageFile!, height: 300,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          pickImage("camera");
                        }, 
                        icon: const Icon(Icons.camera_alt), 
                        label: const Text("Open Camera")
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          pickImage("gallery");
                        }, 
                        icon: const Icon(Icons.add_photo_alternate), 
                        label: const Text("Open Gellery")
                      ),
                    ],
                  ),
                  fileName != null ? Text(fileName!) : const Text(""),
                  builTextFormField(marqueController, TextInputType.text, 1, 1, TextInputAction.next, "  Marque  "),
                  builTextFormField(modeleController, TextInputType.text, 1, 1, TextInputAction.next, "  Modele  "),
                  builTextFormField(typeController, TextInputType.text, 1, 1, TextInputAction.next, "  Type  "),
                  builTextFormField(rateController, TextInputType.number, 1, 1, TextInputAction.next, "  Rate  "),
                  builTextFormField(speedController, TextInputType.number, 1, 1, TextInputAction.next, "  Speed  "),
                  builTextFormField(rangeController, TextInputType.number, 1, 1, TextInputAction.done, "  Range  "),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Current Station",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 20,),
                          Container(
                            width: MediaQuery.of(context).size.width / 2 - 40,
                            height: 40,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 0
                            ),
                            child: StreamBuilder(
                              stream: readStationsNames(),
                              builder: (BuildContext context, AsyncSnapshot snapshot) {
                                if(snapshot.hasError) {
                                  return const Text("Something was wrong");
                                } else if(snapshot.hasData) {
                                  List stations = snapshot.data as List;
                                  return DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      value: stationName,
                                      items: stations.map((station) => DropdownMenuItem(
                                        value: station, 
                                        child: Text(station)
                                      )).toList(), 
                                      onChanged: (value) {
                                        setState(() {
                                          stationName = "$value";
                                        });
                                      }
                                    ),
                                  );
                                } else {
                                  return const Center(child: CircularProgressIndicator());
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  builTextFormField(descriptionController, TextInputType.multiline, 3, 5, TextInputAction.newline, "  Description  "),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _loading ? const Center(
                          child: CircularProgressIndicator(),
                        ) : ElevatedButton(
                          onPressed: () async {
                            if(fileName == null || imageFile == null) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please choose an image for this bike !")));
                              return;
                            }
                            if(stationName == null) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please choose the current station for this bike !")));
                              return;
                            }
                            if(!formkey.currentState!.validate() == true) {
                              return;
                            }
                            setState(() {
                              _loading = true;
                            });
                            final bikesRef = FirebaseFirestore.instance.collection('bikes').doc();
                            
                            await firebaseStorage.ref('/bikes')
                            .child(bikesRef.id)
                            .child(fileName!)
                            .putFile(imageFile!);
                            
                            final photo = await firebaseStorage.ref('/bikes')
                            .child(bikesRef.id)
                            .child(fileName!)
                            .getDownloadURL();

                            BikeModel bike = BikeModel(
                              bid: bikesRef.id, 
                              type: marqueController.text.trim(), 
                              model: modeleController.text.trim(), 
                              brand: typeController.text.trim(),  
                              range:  int.parse(rangeController.text.trim()), 
                              speed: int.parse(speedController.text.trim()), 
                              rating: double.parse(rateController.text.trim()),
                              description: descriptionController.text.trim(), 
                              image: photo,
                              currentStation: stationName!,
                            );

                            await bikesRef.set(bike.toMap());

                            setState(() {
                              marqueController.text = "";
                              modeleController.text = "";
                              typeController.text = "";
                              rangeController.text = "";
                              speedController.text = "";
                              rateController.text = "";
                              descriptionController.text = "";
                              fileName = null;
                              imageFile = null;
                              _loading = false;
                            });
                          }, 
                          child: const Text("Add Bike", style: TextStyle(fontSize: 18))
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  Widget builTextFormField(TextEditingController controller, keyboardType, int? minLines, maxLines,textInputAction, labelText) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: TextFormField(
      validator: (value) => controller.text == "" ? "this field is required" : null,
      minLines: minLines,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      controller: controller,
      style: const TextStyle(
          fontSize: 18
      ),
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            fontSize: 16
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
    ),
  );

  Stream<List<dynamic>> readStationsNames() => FirebaseFirestore.instance.collection('stations').snapshots().map((snapshot) => snapshot.docs.map((doc) => doc.data()['name']).toList());

  // Storage
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<void> pickImage(source) async {
    XFile? pickedImage = await ImagePicker().pickImage(source: source == "camera" ? ImageSource.camera : ImageSource.gallery,);
    if(pickedImage == null) return;
    setState(() {
      fileName = pickedImage.name;
      imageFile = File(pickedImage.path);
    });
  }
}