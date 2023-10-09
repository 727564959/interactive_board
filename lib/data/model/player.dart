class PlayerInfo {
  PlayerInfo({
    required this.id,
    required this.nickname,
    required this.avatarUrl,
    required this.joinedCount,
    required this.username,
  });
  final String id;
  final String username;
  final String nickname;
  final String avatarUrl;
  final int joinedCount;

  factory PlayerInfo.fromJson(Map<String, dynamic> json) {
    final String avatarUrl = "http://10.1.4.13:1337${json['avatarUrl']}";
    return PlayerInfo(
      id: json['id'].toString(),
      nickname: json['nickname'],
      avatarUrl: avatarUrl,
      joinedCount: json['joined'] ?? 0,
      username: json['username'],
    );
  }
}
