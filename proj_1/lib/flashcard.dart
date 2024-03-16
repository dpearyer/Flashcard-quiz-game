class Flashcard {
  final int? id;
  final String term;
  final String definition;

  Flashcard({this.id, required this.term, required this.definition});


 Map<String, dynamic> toMap() {
    return {
      'term': term,
      'definition': definition,
    };
  }
}