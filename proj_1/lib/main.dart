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
              )
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
  }
}