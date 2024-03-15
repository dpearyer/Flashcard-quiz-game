import "package:flutter/material.dart";


class FlashcardView extends StatelessWidget{

  final String text;


  // ignore: prefer_const_constructors_in_immutables
  FlashcardView({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

