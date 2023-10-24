class GameRecords {
  GameRecords({
    required this.redScore,
    required this.blueScore,
  });
  final String redScore;
  final String blueScore;

  factory GameRecords.fromJson(Map<String, dynamic> json) {
    // final String avatarUrl = "http://10.1.4.13:1337${json['avatarUrl']}";
    return GameRecords(
      redScore: json['red'],
      blueScore: json['blue'],
    );
  }
}
