class BasePlayerInfo {
  BasePlayerInfo({
    required this.id,
    required this.nickname,
    required this.avatarUrl,
    required this.username,
  });
  final String id;
  final String username;
  final String nickname;
  final String avatarUrl;

  factory BasePlayerInfo.fromJson(Map<String, dynamic> json) {
    final String avatarUrl = "http://10.1.4.13:1337${json['avatarUrl']}";
    return BasePlayerInfo(
      id: json['id'].toString(),
      nickname: json['nickname'],
      avatarUrl: avatarUrl,
      username: json['username'],
    );
  }
}
