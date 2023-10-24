class GameStatistics {
  GameStatistics({
    required this.nickname,
    required this.tableId,
    required this.avatarUrl,
    required this.username,
    required this.team,
    required this.position,
    required this.rank,
    required this.score,
    required this.shoots,
    required this.calories,
  });
  final String nickname;
  final String tableId;
  final String avatarUrl;
  final String username;
  final String team;
  final String position;
  final String rank;
  final String score;
  final String shoots;
  final String calories;

  factory GameStatistics.fromJson(Map<String, dynamic> json) {
    final String avatarUrl = "http://10.1.4.13:1337${json['player'].avatarUrl}";
    return GameStatistics(
      nickname: json['player'].nickname,
      tableId: json['player'].tableId,
      avatarUrl: avatarUrl,
      username: json['player'].username,
      team: json['player'].team,
      position: json['player'].position,
      rank: json['gameRecord'].rank,
      score: json['gameRecord'].score,
      shoots: json['gameRecord'].shoots,
      calories: json['gameRecord'].calories,
    );
  }
}
