class PlayerInfo {
  PlayerInfo({
    required this.id,
    required this.nickname,
    required this.avatarUrl,
    required this.joinedCount,
  });
  final int id;
  final String nickname;
  final String avatarUrl;
  final int joinedCount;

  factory PlayerInfo.fromJson(Map<String, dynamic> json) {
    late final String avatarUrl;
    if (json['avatarUrl'] == null) {
      avatarUrl = "";
    } else {
      avatarUrl = "http://10.0.0.4:1337${json['avatarUrl']}";
    }
    return PlayerInfo(
      id: json['id'],
      nickname: json['nickname'],
      avatarUrl: avatarUrl,
      joinedCount: json['joinedCount'] ?? 0,
    );
  }
}
