class TeamScore {
  TeamScore({
    required this.redScore,
    required this.blueScore,
  });
  final int redScore;
  final int blueScore;

  factory TeamScore.fromJson(Map<String, dynamic> json) {
    print("json $json");
    return TeamScore(
      redScore: json['red'],
      blueScore: json['blue'],
    );
  }
}
