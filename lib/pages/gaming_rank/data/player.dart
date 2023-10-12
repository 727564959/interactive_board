class PlayerInfo {
  PlayerInfo({
    required this.id,
    required this.nickname,
    required this.avatarUrl,
    required this.username,
    required this.position,
  });
  final String id;
  final String username;
  final String nickname;
  final String avatarUrl;
  final int position;

  factory PlayerInfo.fromJson(Map<String, dynamic> json) {
    final String avatarUrl = "http://10.1.4.13:1337${json['avatarUrl']}";
    return PlayerInfo(
      id: json['id'].toString(),
      nickname: json['nickname'],
      avatarUrl: avatarUrl,
      username: json['username'],
      position: json['position'],
    );
  }
}

class PlayerRecord {
  PlayerRecord({required this.player, this.score = 0});
  final PlayerInfo player;
  int score;
}
