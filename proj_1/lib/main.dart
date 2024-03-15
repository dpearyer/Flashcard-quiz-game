import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FlashCardApp(title: 'CogniCards'),
    );
  }
}

class FlashCardApp extends StatefulWidget {
  const FlashCardApp({super.key, required this.title});

  final String title;

  @override
  State<FlashCardApp> createState() => _FlashCardAppState();
}

class _FlashCardAppState extends State<FlashCardApp> {
 
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 350,
                  height: 250,
                  child: FlipCard(
                      front: FlashcardView(
                        text: _flashcards[_currentIndex].term,
                      ),
                      back: FlashcardView(
                        text: _flashcards[_currentIndex].definition,
                      ))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton.icon(
                      onPressed: showPreviousCard,
                      icon: Icon(Icons.chevron_left),
                      label: Text('')),
                  OutlinedButton.icon(
                      onPressed: showNextCard,
                      icon: Icon(Icons.chevron_right),
                      label: Text('')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }