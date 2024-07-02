class QuestionInfo {
  QuestionInfo({
    required this.title,
    required this.selections,
    required this.type,
    required this.correctAnswer,
    required this.round,
  });

  final String title;
  final List<String> selections;
  final String type;
  final int correctAnswer;
  final int round;
  factory QuestionInfo.fromJson(Map<String, dynamic> json) {
    final question = json['question'];
    return QuestionInfo(
      title: question['title'],
      selections: question['answers'].cast<String>(),
      type: question['type'],
      correctAnswer: question['correctAnswer'],
      round: json['round'],
    );
  }
}
