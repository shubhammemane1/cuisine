import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userSetup(String fname, String lname, String email) async {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  CollectionReference ref = firebaseFirestore.collection('Cuisine User');
  ref.add({
    'First Name ': fname,
    'Last Name': lname,
    'email': email,
    'uid': firebaseAuth.currentUser.uid,
  });
}

class Authentication {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> signUp(
      String fname, String lname, String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Success";
    } catch (e) {
      print(e);
    }
  }

  Future<void> logIn(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Success";
    } catch (e) {
      print(e);
    }
  }
}
