import 'package:cuisine/models/cuisine.dart';
import 'package:cuisine/screens/Meal_details.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../dummy_data.dart';

class MealList extends StatefulWidget {
  final String categoryId;
  final String categoryName;
  MealList(this.categoryId, this.categoryName);
  @override
  _MealListState createState() => _MealListState();
}

class _MealListState extends State<MealList> {
  List<Dishes> dishes = [];
  List<Dishes> filterd = [];
  Dishes dish;

  SharedPreferences _prefs;

  Future<void> _initializeData() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    dishes = Cuisine_Dishes;
    dishes.forEach((dish) {
      if (dish.cuisine.contains(widget.categoryId)) {
        filterd.add(dish);
      }
    });
    _initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: GridView.builder(
        shrinkWrap: true,
        controller: ScrollController(),
        itemCount: filterd.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5 / 1,
        ),
        itemBuilder: (ctx, i) {
          return GestureDetector(
            // tag: filterd[i].id,
            child: Container(
              child: Card(
                elevation: 5,
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
                            image: FirebaseImage(filterd[i].img),
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
                            icon: Icon(filterd[i].favourite == false
                                ? Icons.favorite_border
                                : Icons.favorite),
                            color: Colors.red,
                            onPressed: () {
                              filterd[i].favourite = !filterd[i].favourite;

                              _prefs.setBool(
                                  '${filterd[i].id}', filterd[i].favourite);

                              setState(() {});
                            }),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        filterd[i].name,
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.headline5.copyWith(
                            backgroundColor: Colors.white24,
                            color: Colors.white,
                            fontSize: size.width * 0.06),
                      ),
                    )
                  ],
                ),
              ),
            ),

            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => MealDeatils(filterd[i])));
            },
          );
        },
      ),
    );
  }
}
