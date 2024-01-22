class PlayerInfo {
  PlayerInfo({
    required this.id,
    required this.nickname,
    required this.avatarUrl,
    required this.joinedCount,
    required this.tableId,
  });
  final int id;
  final String nickname;
  final String avatarUrl;
  final int joinedCount;
  final int tableId;

  factory PlayerInfo.fromJson(Map<String, dynamic> json, int tableId) {
    late final String avatarUrl;
    if (json['avatarUrl'] == null) {
      avatarUrl = "";
    } else {
      avatarUrl = "http://10.1.4.16:1337${json['avatarUrl']}";
    }
    return PlayerInfo(
      id: json['id'],
      nickname: json['nickname'],
      avatarUrl: avatarUrl,
      joinedCount: json['joinedCount'] ?? 0,
      tableId: tableId,
    );
  }
}
