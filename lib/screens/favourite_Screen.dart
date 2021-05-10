import 'package:cuisine/dummy_data.dart';
import 'package:cuisine/models/cuisine.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Meal_List.dart';
import 'Meal_details.dart';
import 'Meal_details.dart';

class FavouriteScreen extends StatefulWidget {
  final List<Cuisine> favourite;
  FavouriteScreen(this.favourite);

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  SharedPreferences prefs;

  List<Cuisine> favs = [];
  List<Dishes> favDish = [];

  ///[asa buildcontxt kadhich declare karaicha nahi]
  ///[stateful widget madhe directly available asto purna class madhe]
  ///[stateless madhe method la pass karaicha jithe lagto]
  // BuildContext context;

  bool myCuisineBool;
  bool myDishesBool;

  Size size;
  TextTheme textTheme;

  //initalize all data before displaying
  Future<void> _getData() async {
    favs = [];
    favDish = [];
    prefs = await SharedPreferences.getInstance();

    //getting all favourite cuisines
    Cuisine_data.forEach((cuisine) {
      String key = cuisine.id;
      if (prefs.containsKey(key)) {
        bool isFavourite = prefs.getBool(key);
        cuisine.favourite = isFavourite;
        if (isFavourite) {
          favs.add(cuisine);
        }
      }
    });

    //getting all favourites dishes
    Cuisine_Dishes.forEach((dish) {
      String key = dish.id;
      if (prefs.containsKey(key)) {
        bool isFavourite = prefs.getBool(key);
        dish.favourite = isFavourite;
        if (isFavourite) favDish.add(dish);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourites"),
        elevation: 0,
      ),
      body: Container(
        child: FutureBuilder<void>(
            future: _getData(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error),
                );
              }
              if (favs.length == 0 && favDish.length == 0) {
                return Center(
                  child: Text('Nothing is added here...'),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ///[Cuisines]
                    _buildCuisinesList(),

                    ///[Dishesh]
                    _buildDisheshList(),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget _buildCuisinesList() {
    return favs.length == 0
        ? SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Cuisines",
                  style: textTheme.headline5,
                ),
              ),
              //items list
              ListView.builder(
                shrinkWrap: true,
                itemCount: favs.length,
                itemBuilder: (ctx, i) {
                  return SizedBox(
                    height: size.height * 0.25,
                    width: size.width,
                    child: InkWell(
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
                                  image: FirebaseImage(
                                    favs[i].img,
                                  ),
                                ),
                              ),
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
                                    favs[i].favourite == false
                                        ? Icons.favorite_border
                                        : Icons.favorite,
                                  ),
                                  color: Colors.red,
                                  onPressed: () async {
                                    setState(() {
                                      favs[i].favourite = !favs[i].favourite;
                                      prefs.setBool(
                                          '${favs[i].id}', favs[i].favourite);
                                    });
                                  },
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                favs[i].name,
                                textAlign: TextAlign.end,
                                style: textTheme.headline5.copyWith(
                                  backgroundColor: Colors.white24,
                                  color: Colors.white,
                                  fontSize: size.width * 0.08,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => MealList(
                              favs[i].id,
                              favs[i].name,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          );
  }

  Widget _buildDisheshList() {
    return favDish.length == 0
        ? SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Dishes",
                  style: textTheme.headline5,
                ),
              ),
              //items list
              ListView.builder(
                shrinkWrap: true,
                itemCount: favDish.length,
                itemBuilder: (ctx, i) {
                  return SizedBox(
                    height: size.height * 0.25,
                    width: size.width,
                    child: InkWell(
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
                                  image: FirebaseImage(
                                    favDish[i].img,
                                  ),
                                ),
                              ),
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
                                    favDish[i].favourite == false
                                        ? Icons.favorite_border
                                        : Icons.favorite,
                                  ),
                                  color: Colors.red,
                                  onPressed: () async {
                                    setState(() {
                                      favDish[i].favourite =
                                          !favDish[i].favourite;
                                      prefs.setBool('${favDish[i].id}',
                                          favDish[i].favourite);
                                    });
                                  },
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                favDish[i].name,
                                textAlign: TextAlign.end,
                                style: textTheme.headline5.copyWith(
                                  backgroundColor: Colors.white24,
                                  color: Colors.white,
                                  fontSize: size.width * 0.08,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => MealDeatils(favDish[i]),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          );
  }
}
