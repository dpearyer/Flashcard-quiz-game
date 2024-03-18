import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/widgets.dart';
import 'flashcard_view.dart';
import 'flashcard.dart';
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
      home: const HomePage(title: 'CogniCards'),
    );
  }
}



class HomePage extends StatefulWidget{
  const HomePage({Key?key, required String title}): super(key:key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  
  @override

  Widget build(BuildContext context){
  return MaterialApp(
  home: Scaffold(
    appBar: AppBar(
        title: const Text('Cognicode', textAlign: TextAlign.center,),
        backgroundColor: Colors.purple,
        elevation: 4,
        titleTextStyle:TextStyle(
        color: Colors.white ,
        fontSize: 24,
        
      ),
    ),
   body: Center(
        child: Row(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyCard(title: 'Set 1')),
                );
            
              },
              child: Text('Set 1'),
            style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow,
            minimumSize: Size(50, 50), // Adjust the size as needed
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
            
 // Adjust the border radius as needed
            ),
          ),
        ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyCard(title: 'Set 2')),
                );
              },
              child: Text('Set 2'),

              style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlue,
            minimumSize: Size(50, 50), // Adjust the size as needed
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.0), // Adjust the border radius as needed
            ),
          ),
        ),
            
            // Add more buttons for additional sets
          ],
        ),
      ),
  ),
    );
  }
}

class MyCard extends StatefulWidget {
  const MyCard({super.key, required this.title});

  final String title;

  @override
  State<MyCard> createState() => _FlashCardAppState();
}

class _FlashCardAppState extends State<MyCard> {
 List<Flashcard> _flashcards =[
  Flashcard( 
    term: "osmosis",
    definition: "explanation"
  ),
  Flashcard( 
    term: "osmosis 2",
    definition: "explanation 2"
  )
 ];
   int _currentIndex = 0;

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
                      
                      front:
                        FlashcardView(
                        text: _flashcards[_currentIndex].term,
                        
                    ),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
                      back: 
                        FlashcardView(
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
              ),
              ElevatedButton(
                onPressed: () => _startQuiz( _currentIndex),
                child: Text('Start Quiz'),
          ),
            ],
          
          ),
          
        ),
         floatingActionButton: FloatingActionButton.small(
        onPressed: () async{
           final newFlashcard = await showDialog<Flashcard>(
      context: context,
      builder: (BuildContext context) {
        String term = '';
        String definition = '';
        return AlertDialog(
          title: Text('Add New Flashcard'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                onChanged: (value) {
                  term = value;
                },
                decoration: InputDecoration(labelText: 'Term'),
              ),
              TextFormField(
                onChanged: (value) {
                  definition = value;
                },
                decoration: InputDecoration(labelText: 'Definition'),
              ),
            ],
          
            
          ),
      
         
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),     
            ),
            ElevatedButton(
              onPressed: () {
                final newFlashcard = Flashcard(term: term, definition: definition);
                Navigator.pop(context, newFlashcard);
              },
              child: Text('Add'),
            ),

              
          ],
          
        );
        
      },
    );

    if (newFlashcard != null) {
      setState(() {
        _flashcards.add(newFlashcard);
      });
    }
  },
  backgroundColor: Colors.deepPurple,
  child: Icon(Icons.add),
  
         ),
floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }
   void showNextCard() {
    setState(() {
      _currentIndex =
          (_currentIndex + 1 < _flashcards.length) ? _currentIndex + 1 : 0;
    });
  }

  void showPreviousCard() {
    setState(() {
      _currentIndex =
          (_currentIndex - 1 >= 0) ? _currentIndex - 1 : _flashcards.length - 1;
    });
  }

int _calculateCorrectAnswers( List<Flashcard> flashcards) {
  int correctAnswers = 0;
  for (var i = 0; i < flashcards.length; i++) {
    if (flashcards[i].userAnswer == flashcards[i].term) {
      correctAnswers++;
    }
  }
  return correctAnswers;
  }


 void _startQuiz(int currentIndex) {
  List<Flashcard> currentFlashcards = _flashcards; 
  int totalQuestions = currentFlashcards.length;
  int correctAnswers = _calculateCorrectAnswers(currentFlashcards);
  
  Navigator.push(
    context as BuildContext,
    MaterialPageRoute(
      builder: (context) => QuizModeScreen(
        flashcards: currentFlashcards,
        totalQuestions: totalQuestions,
        correctAnswers: correctAnswers,
      ),
    ),
  );
    }
}

    class QuizModeScreen extends StatefulWidget {
  final List<Flashcard> flashcards;
  final int totalQuestions;
  final int correctAnswers;

  QuizModeScreen({required this.flashcards, required this.totalQuestions, required this.correctAnswers,});

  @override
  _QuizModeScreenState createState() => _QuizModeScreenState();
}

class _QuizModeScreenState extends State<QuizModeScreen> {
 

  int currentIndex = 0;
  int score = 0;
  TextEditingController textEditingController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Mode'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Definition: ${widget.flashcards[currentIndex].definition}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: 'Enter the correct term',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (textEditingController.text ==
                    widget.flashcards[currentIndex].term) {
                  setState(() {
                    score++;
                  });
                }
                if (currentIndex < widget.flashcards.length - 1) {
                  setState(() {
                    currentIndex++;
                    textEditingController.clear();
                  });
                } else {
                  // Navigate to the score screen or perform any other action

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScoreScreen(score: score, totalQuestions: null, flashcards: [], correctAnswers: null,),
                    ),
                  );
                }
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}


class QuizScoreScreen extends StatelessWidget {
  final int? totalQuestions;
  final int? correctAnswers;
  final List<Flashcard> flashcards;

  QuizScoreScreen({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.flashcards, required int score,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Score'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You got $correctAnswers out of $totalQuestions correct!'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to the quiz screen
              },
              child: Text('Try Again'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the screen showing correct answers
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CorrectAnswersScreen(flashcards: flashcards),
                  ),
                );
              },
              child: Text('Show Correct Answers'),
            ),
          ],
        ),
      ),
    );
  }
}

class CorrectAnswersScreen extends StatelessWidget {
  final List<Flashcard> flashcards;

  CorrectAnswersScreen({required this.flashcards});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Correct Answers'),
      ),
      body: ListView.builder(
        itemCount: flashcards.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Term: ${flashcards[index].term}'),
            subtitle: Text('Definition: ${flashcards[index].definition}'),
          );
        },
      ),
    );
  }
  


}
