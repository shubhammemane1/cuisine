import 'package:cuisine/services/auth.dart';
import 'package:cuisine/widgets/my_Button.dart';
import 'package:cuisine/widgets/my_TextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Authentication _auth = Authentication();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool login = true;

  String fname;
  String lname;
  String email;
  String password;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: size.width * 0.9,
            padding: EdgeInsets.only(top: size.height * 0.06),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  scale: 1.5,
                ),
                Text(
                  login == true ? "Login" : "Signup",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: size.width * 0.09),
                ),
                login == true
                    ? Container()
                    : AnimatedContainer(
                        curve: Curves.bounceInOut,
                        duration: new Duration(minutes: 10),
                        child: Column(
                          children: [
                            AnimationConfiguration.staggeredList(
                                position: 1,
                                duration: const Duration(milliseconds: 375),
                                child: Column(
                                  children: [
                                    FlipAnimation(
                                      // verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: MyTextField(
                                          text: "First Name",
                                          icon: Icons.person,
                                          obsecuretext: false,
                                          function: (value) {
                                            fname = value;
                                          },
                                        ),
                                      ),
                                    ),
                                    FlipAnimation(
                                      // verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: MyTextField(
                                          text: "Last Name",
                                          icon: Icons.person,
                                          obsecuretext: false,
                                          function: (value) {
                                            lname = value;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                AnimatedContainer(
                  curve: Curves.bounceInOut,
                  duration: Duration(seconds: 5),
                  child: AnimationConfiguration.staggeredList(
                      position: 1,
                      duration: const Duration(milliseconds: 375),
                      child: Column(
                        children: [
                          FlipAnimation(
                            child: FadeInAnimation(
                              child: MyTextField(
                                text: "Email",
                                icon: Icons.alternate_email,
                                obsecuretext: false,
                                function: (value) {
                                  email = value;
                                },
                              ),
                            ),
                          ),
                          FlipAnimation(
                            child: MyTextField(
                              text: "password",
                              icon: Icons.vpn_key,
                              obsecuretext: true,
                              function: (value) {
                                password = value;
                              },
                            ),
                          ),
                        ],
                      )),
                ),
                loading == true
                    ? CircularProgressIndicator(
                        backgroundColor: Colors.black,
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : MyButton(
                        id: login == true ? "Login" : "SignUp",
                        // color: Theme.of(context).primaryColor,
                        // textColor: Colors.white,
                        function: login == true
                            ? () async {
                                setState(() {
                                  loading = true;
                                });
                                print(email.toString());
                                print(password);
                                await _auth
                                    .logIn(email, password)
                                    .then((signInUser) {
                                  setState(() {
                                    loading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Welcome ${_auth.firebaseAuth.currentUser.email}")));
                                  Navigator.of(context)
                                      .pushReplacementNamed('/home');
                                }).catchError((e) {
                                  print(e);
                                });
                              }
                            : () async {
                                setState(() {
                                  loading = true;
                                });
                                await _auth
                                    .signUp(fname, lname, email, password)
                                    .then((signInUser) {
                                  setState(() {
                                    loading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Account Has been Created")));
                                }).catchError((e) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(content: Text(e)));
                                });
                                userSetup(fname, lname, email);
                              },
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(login == true
                        ? "Don't Have An Account ?"
                        : "Already Have an Account"),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            if (login == true) {
                              login = false;
                            } else {
                              login = true;
                            }
                          });
                        },
                        child: Text(
                          login == true ? "Sign up" : "Login",
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
