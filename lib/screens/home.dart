import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuisine/dummy_data.dart';
import 'package:cuisine/models/cuisine.dart';
import 'package:cuisine/screens/favourite_Screen.dart';
import 'package:cuisine/screens/menu_Screen.dart';
import 'package:cuisine/widgets/my_Button.dart';
import 'package:cuisine/widgets/my_TextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_Screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Cuisine> favourite = [];

  List<DropdownMenuItem<Cuisine>> dropdown;

  int index = 0;
  FirebaseAuth firebase = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      MenuScreen(),
      FavouriteScreen(favourite),
    ];
    return Scaffold(
      body: pages[index],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          Navigator.of(context).pushNamed('/add');
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        selectedLabelStyle:
            TextStyle(color: Colors.red, decorationColor: Colors.amber),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.restaurant_menu_outlined,
            ),
            label: "Menu",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(
              Icons.favorite,
              color: Colors.amber,
            ),
            label: "Favourites",
          ),
        ],
      ),
    );
  }
}
// Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         image: DecorationImage(
//                             fit: BoxFit.cover,
//                             image: FirebaseImage(Cuisine_data[i].img))),
//                     child: Container(
//                       color: Colors.white,
//                       child: Text(
//                         Cuisine_data[i].name,
//                         textWidthBasis: TextWidthBasis.parent,
//                         style: Theme.of(context).textTheme.headline6,
//                       ),
//                     ),
//                   )
