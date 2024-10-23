class QuestionInfo {
  QuestionInfo({
    required this.title,
    required this.choices,
    required this.category,
    required this.answer,
    required this.round,
  });

  final String title;
  final List<String> choices;
  final String category;
  final int answer;
  final int round;
  factory QuestionInfo.fromJson(Map<String, dynamic> json) {
    final question = json['question'];
    return QuestionInfo(
      title: question['title'],
      choices: question['choices'].cast<String>(),
      category: question['category'],
      answer: question['answer'],
      round: json['round'],
    );
  }
}
