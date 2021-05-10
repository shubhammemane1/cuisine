import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuisine/widgets/my_Button.dart';
import 'package:cuisine/widgets/my_TextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class AddDishScreen extends StatefulWidget {
  @override
  _AddDishScreenState createState() => _AddDishScreenState();
}

class _AddDishScreenState extends State<AddDishScreen> {
  String dropdownId;
  String recipeName;
  String time;
  String ingridient;
  String recipe;
  File storedImage;

  String _chosenValue;
  String imageUrl = '';

  var downloadUrl = '';

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<void> _takePicture() async {
    final image = ImagePicker();
    final imageFile = await image.getImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      storedImage = File(
        imageFile.path,
      );
    });

    var snapshot = await firebaseStorage
        .ref()
        .child('${_chosenValue}/${DateTime.now()}')
        .putFile(storedImage);
    downloadUrl = await snapshot.ref.getDownloadURL();
    print(downloadUrl);
    setState(() {
      imageUrl = downloadUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Recipe'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.2,
              child: Column(
                children: [
                  DropdownButton<String>(
                    focusColor: Colors.white,
                    value: _chosenValue,
                    //elevation: 5,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    icon: Icon(Icons.food_bank_outlined),
                    items: <String>[
                      'Indian',
                      'Chinese',
                      'Thai',
                      'Maharastrian',
                      'Punjabi',
                      'South Indian',
                      'Rajasthani',
                      'Gujrathi',
                      'Fast Food'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "Select Cuisine",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),

                    onChanged: (value) {
                      setState(() {
                        _chosenValue = value;
                      });
                    },
                  ),
                  MyTextField(
                    text: 'Recipe name',
                    icon: Icons.brush_outlined,
                    obsecuretext: false,
                    function: (value) {
                      recipeName = value;
                    },
                  ),
                  MyTextField(
                    text: 'time required',
                    icon: Icons.av_timer,
                    obsecuretext: false,
                    function: (value) {
                      time = value;
                    },
                  ),
                  MyTextField(
                    text: 'ingridients',
                    icon: Icons.receipt_long_rounded,
                    obsecuretext: false,
                    function: (value) {
                      ingridient = value;
                    },
                  ),
                  MyTextField(
                    text: 'recipe',
                    icon: Icons.receipt_long_rounded,
                    obsecuretext: false,
                    function: (value) {
                      recipe = value;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: size.width * 0.6,
                        height: size.height * 0.2,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                        ),
                        child: storedImage != null
                            ? Image.file(
                                storedImage,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              )
                            : Text(
                                'No Image Taken',
                                textAlign: TextAlign.center,
                              ),
                        alignment: Alignment.center,
                      ),
                      ElevatedButton.icon(
                          onPressed: _takePicture,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                          ),
                          icon: Icon(Icons.add_photo_alternate_outlined),
                          label: Text("Gallery"))
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  MyButton(
                    id: "ADD RECIPE",
                    function: () {
                      if (FirebaseAuth.instance.currentUser != null) {
                        CollectionReference ref =
                            FirebaseFirestore.instance.collection(_chosenValue);
                        ref.add({
                          "cuisine": _chosenValue,
                          'name': recipeName,
                          'time': time,
                          'ingredients': ingridient,
                          'recipe': recipe,
                          'img': downloadUrl,
                        });
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Your not LOgged in"),
                                content: Text("Please login to add recipe !"),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text('no')),
                                  TextButton(
                                      onPressed: () => Navigator.of(context)
                                          .popAndPushNamed('/login'),
                                      child: Text('yes')),
                                ],
                              );
                            });
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// id:"",
//     name: ,
//     time: ,
//     cuisine: ,
//     ingredients: ,
//     recipe: ,
//     img: ,
