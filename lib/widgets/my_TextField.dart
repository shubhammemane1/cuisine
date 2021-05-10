import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool obsecuretext;
  final Function function;

  MyTextField({this.icon, this.text, this.obsecuretext, this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.black,
          ),
          hintText: text,
          border: UnderlineInputBorder(),
          enabledBorder: UnderlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
        ),
        onChanged: function,
        obscureText: obsecuretext,
      ),
    );
  }
}
