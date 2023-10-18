class QuestionInfo {
  QuestionInfo({
    required this.id,
    required this.title,
    required this.selections,
    required this.type,
    required this.correctAnswer,
    required this.round,
  });
  final String id;
  final String title;
  final List<String> selections;
  final String type;
  final int correctAnswer;
  final int round;

  factory QuestionInfo.fromJson(Map<String, dynamic> json) {
    final question = json['question'];
    final selections = <String>[question['answer0'], question['answer1'], question['answer2']];

    return QuestionInfo(
      id: question['id'].toString(),
      title: question['question'],
      selections: selections,
      type: question['type'],
      correctAnswer: question['correctAnswer'],
      round: json['round'],
    );
  }
}
