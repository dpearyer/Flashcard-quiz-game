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
  home: DefaultTabController(
    length: 2,
    child: Scaffold(
    appBar: AppBar(
        bottom: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.card_giftcard, color: Colors.white,)),
            Tab(icon: Icon(Icons.lightbulb, color: Colors.white,)),
           
          ],
        ),
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
  final List<FlashcardSet> _flashcardSets = [
    FlashcardSet(
      title: "Set 1",
      flashcards: [
       Flashcard(term: "Term 1", definition: "Definition 1"),
        Flashcard(term: "Term 2", definition: "Definition 2"),
      ],
    ),
    FlashcardSet(
      title: "Set 2",
      flashcards: [
         Flashcard(term: "Term 3", definition: "Definition 3"),
        Flashcard(term: "Term 4", definition: "Definition 4"),
       
      ],
    ),
  ];
  int _currentIndex = 0;
  


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 350,
                height: 250,
                child: FlipCard(
                  front: FlashcardView(
                    text: _flashcardSets[_currentIndex].flashcards[_currentIndex].term,
                  ),
                  back: FlashcardView(
                    text: _flashcardSets[_currentIndex].flashcards[_currentIndex].definition,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton.icon(
                    onPressed: showPreviousCard,
                    icon: Icon(Icons.chevron_left),
                    label: Text(''),
                  ),
                  OutlinedButton.icon(
                    onPressed: showNextCard,
                    icon: Icon(Icons.chevron_right),
                    label: Text(''),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () => _addNewFlashcard(),
                child: Text('Add Flashcard'),
              ),
              ElevatedButton(
                onPressed: () => _startQuiz(),
                child: Text('Start Quiz'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.small(
          onPressed: () => _createNewSet(),
          backgroundColor: Colors.deepPurple,
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }

  void showNextCard() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _flashcardSets.length;
    });
  }

  void showPreviousCard() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + _flashcardSets.length) % _flashcardSets.length;
    });
  }

  void _addNewFlashcard() async {
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
                _flashcardSets[_currentIndex].flashcards.add(newFlashcard);
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );

    if (newFlashcard != null) {
      setState(() {
        _flashcardSets[_currentIndex].flashcards.add(newFlashcard);
      });
    }
  }

  void _createNewSet() async {
    final newSet = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String setTitle = '';
        return AlertDialog(
          title: Text('Create New Set'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                onChanged: (value) {
                  setTitle = value;
                },
                decoration: InputDecoration(labelText: 'Set Title'),
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
                if (setTitle.isNotEmpty) {
                  _flashcardSets.add(FlashcardSet(title: setTitle));
                }
                Navigator.pop(context);
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );

    if (newSet != null && newSet.isNotEmpty) {
      setState(() {
        _flashcardSets.add(FlashcardSet(title: newSet));
      });
    }
  }

  void _startQuiz() {
  
  }
}
