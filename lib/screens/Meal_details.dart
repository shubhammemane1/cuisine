import 'package:cuisine/models/cuisine.dart';
import 'package:cuisine/widgets/my_Button.dart';
import 'package:cuisine/widgets/my_TextField.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/my_TextField.dart';

class MealDeatils extends StatefulWidget {
  Dishes filter;
  MealDeatils(Dishes dishes) {
    filter = dishes;
  }

  @override
  _MealDeatilsState createState() => _MealDeatilsState();
}

class _MealDeatilsState extends State<MealDeatils> {
  String notes = "";

  String comments;
  List<String> commentsList = [];

  @override
  void initState() {
    // getnotes();
    super.initState();
  }

  // Future getnotes() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   notes = prefs.getString('notes');
  //   setState(() {});
  // }

  addednotes() {
    if (notes != null)
      return Text(
        notes,
        style: TextStyle(
          color: Colors.black,
          fontSize: MediaQuery.of(context).size.width * 0.05,
        ),
      );
    else
      return Text(
        "Welcome!",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(widget.filter.name),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              Container(
                width: size.width,
                height: size.height * 0.34,
                color: Colors.grey.shade600,
                child: Image(
                  fit: BoxFit.fill,
                  image: FirebaseImage(widget.filter.img),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.32),
                child: Container(
                  padding: EdgeInsets.all(size.width * 0.04),
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(size.width * 0.02),
                        child: Row(
                          children: [
                            Icon(Icons.av_timer),
                            Text(
                              "Time Required :- ",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            Text(
                              widget.filter.time,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(
                                    color: Colors.green.shade700,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: size.width * 0.03),
                        child: Text(
                          'Ingredients',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(size.height * 0.01),
                        // padding: EdgeInsets.all(5),
                        height: size.height * 0.18,
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Colors.black87,
                            ),
                            borderRadius: BorderRadius.circular(25)),
                        child: ListView.builder(
                          itemCount: widget.filter.ingredients.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${index + 1} . ",
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  Flexible(
                                    child: Text(
                                      widget.filter.ingredients[index],
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: size.width * 0.03),
                        child: Text(
                          'Recipe',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(size.height * 0.01),
                        padding: EdgeInsets.all(5),
                        height: size.height * 0.18,
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Colors.black87,
                            ),
                            borderRadius: BorderRadius.circular(25)),
                        child: ListView.builder(
                          itemCount: widget.filter.recipe.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${index + 1}. ",
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  Flexible(
                                    child: Container(
                                      child: Text(
                                        widget.filter.recipe[index],
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          enabledBorder: UnderlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          hintText: "Add Comments",
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            comments = value;
                          });
                          commentsList.add(comments);
                        },
                      ),
                      commentsList == null
                          ? Container()
                          : Container(
                              margin: EdgeInsets.all(size.width * 0.03),
                              // decoration: BoxDecoration(
                              //   border: Border.all(
                              //     color: Colors.grey.shade900,
                              //   ),
                              //   // borderRadius: BorderRadius.circular(20),
                              // ),
                              child: ExpansionTileCard(
                                  baseColor: Colors.grey.shade300,
                                  animateTrailing: true,
                                  borderRadius: BorderRadius.circular(20),
                                  key: GlobalKey(),
                                  title: Text("comments"),
                                  elevation: 5,
                                  leading: Icon(Icons.comment),
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: commentsList.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          leading: CircleAvatar(
                                            child: Icon(Icons.person),
                                          ),
                                          title: Text("Username ${index + 1}"),
                                          subtitle: Text(
                                            commentsList[index],
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        );
                                      },
                                    )
                                  ]),
                            )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.amber,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                    // decoration: BoxDecoration(
                    //   color: Colors.red,
                    //   borderRadius: BorderRadius.only(
                    //     topLeft: Radius.circular(20),
                    //     topRight: Radius.circular(20),
                    //   ),
                    // ),
                    child: Column(
                  children: [
                    MyTextField(
                      icon: Icons.notes,
                      obsecuretext: false,
                      function: (value) {
                        notes = value;
                      },
                      text: "Add Notes Here",
                    ),
                    MyButton(
                      id: 'save',
                      function: () async {
                        if (notes != null) {
                          final SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          pref.setString("notes", notes);
                        }
                      },
                    ),
                    addednotes()
                  ],
                ));
              });
        },
      ),
    );
  }
}
