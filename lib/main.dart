import 'package:cuisine/screens/addDish_screen.dart';
import 'package:cuisine/screens/home.dart';
import 'package:cuisine/screens/login_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.amber,
          appBarTheme: AppBarTheme(
            elevation: 0,
            color: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black),
            textTheme: TextTheme(
              headline6: Theme.of(context).textTheme.headline6,
            ),
          ),
          fontFamily: 'itim',
          textTheme: TextTheme(
            headline4: TextStyle(
              color: Colors.grey.shade900,
              fontSize: 23,
            ),
            headline5: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 22,
            ),
            headline6: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 18,
            ),
          )),
      home: SplashScreenView(
        navigateRoute: HomeScreen(),
        imageSrc: "assets/images/logo.png",
        duration: 50,
        backgroundColor: Colors.white,
        text: "Cuisine",
        textType: TextType.TyperAnimatedText,
        textStyle: TextStyle(
          fontSize: 30.0,
        ),
      ),
      routes: {
        '/home': (ctx) => HomeScreen(),
        '/login': (ctx) => LoginScreen(),
        '/add': (ctx) => AddDishScreen(),
        // '/meal-list': (ctx) => MealList(categoryId),
        // '/meal-details': (ctx) => MealDeatils(),
      },
    );
  }
}
