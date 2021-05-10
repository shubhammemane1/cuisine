import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String id;
  final Function function;

  MyButton({
    this.id,
    this.function,
  });
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.black),
        onPressed: function,
        child: Text(
          id,
          style: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
