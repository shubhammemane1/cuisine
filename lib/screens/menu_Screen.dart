// import 'package:cuisine/models/cuisine.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dummy_data.dart';
import 'Meal_List.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  bool favourite = false;
  SharedPreferences _prefs;

  Future<void> _initializeData() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("assets/images/logo.png"),
              height: size.width * 0.15,
            ),
            Text(
              "Cuisine",
            ),
          ],
        ),
        actions: [
          firebaseAuth.currentUser == null
              ? TextButton(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.amber,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/login');
                  },
                )
              : TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Are Your sure to LogOut ?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("No")),
                              TextButton(
                                  onPressed: () async {
                                    await firebaseAuth.signOut().then((value) {
                                      Navigator.of(context)
                                          .popAndPushNamed('/login');
                                    });
                                  },
                                  child: Text("Yes")),
                            ],
                          );
                        });
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(color: Colors.amber),
                  ),
                ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: _initializeData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    controller: ScrollController(),
                    itemCount: Cuisine_data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 2 / 1,
                    ),
                    itemBuilder: (ctx, i) {
                      if (_prefs.containsKey('${Cuisine_data[i].id}'))
                        Cuisine_data[i].favourite =
                            _prefs.getBool('${Cuisine_data[i].id}');

                      return InkWell(
                        child: Card(
                          elevation: 5,
                          margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FirebaseImage(Cuisine_data[i].img),
                                    )),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white54,
                                  ),
                                  child: IconButton(
                                      icon: Icon(
                                          Cuisine_data[i].favourite == false
                                              ? Icons.favorite_border
                                              : Icons.favorite),
                                      color: Colors.red,
                                      onPressed: () async {
                                        Cuisine_data[i].favourite =
                                            !Cuisine_data[i].favourite;

                                        _prefs.setBool('${Cuisine_data[i].id}',
                                            Cuisine_data[i].favourite);

                                        setState(() {});
                                      }),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  Cuisine_data[i].name,
                                  textAlign: TextAlign.end,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(
                                          backgroundColor: Colors.white24,
                                          color: Colors.white,
                                          fontSize: size.width * 0.08),
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => MealList(
                                  Cuisine_data[i].id, Cuisine_data[i].name)));
                        },
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
