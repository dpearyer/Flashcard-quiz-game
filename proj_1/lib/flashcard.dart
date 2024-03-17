class Flashcard {
  final int? id;
  final int? setId;
  final String? title;
  final String term;
  final String definition;
 

  Flashcard({required this.term, required this.definition,    this.id,
     this.setId, this.title=''});



  Map<String, dynamic> toMap(int setId) {
    return {
      'id': id ?? '',
      'term': term,
      'definition': definition,
      'setId': setId,
      'title': title ?? '',
    };
  }
}

class FlashcardSet {
  final String title;
  final List<Flashcard> flashcards;

  FlashcardSet({required this.title, this.flashcards = const []});
}


 
