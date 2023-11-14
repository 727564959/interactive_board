class GameRecords {
  GameRecords({
    required this.username,
    required this.nickname,
    required this.tableId,
    required this.avatarUrl,
    required this.team,
    required this.position,
    required this.rank,
    required this.score,
  });
  final String username;
  final String nickname;
  final int tableId;
  final String avatarUrl;
  final int team;
  final int position;
  final int rank;
  final int score;

  factory GameRecords.fromJson(Map<String, dynamic> json) {
    // print("json $json");
    // final String avatarUrl =
    //     "http://www.mir2021.xyz:1337${json['player']['avatarUrl']}";
    final String avatarUrl =
        "http://10.1.4.13:1337${json['player']['avatarUrl']}";
    // print("avatarUrl $avatarUrl");
    return GameRecords(
      username: json['player']['username'],
      nickname: json['player']['nickname'],
      tableId: json['player']['tableId'],
      avatarUrl: avatarUrl,
      team: json['player']['team'],
      position: json['player']['position'],
      rank: json['gameRecord']['rank'],
      score: json['gameRecord']['score'],
    );
  }
}
