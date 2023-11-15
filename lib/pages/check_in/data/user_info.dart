class UserInfo {
  UserInfo({
    required this.id,
    required this.nickname,
    required this.avatarUrl,
    required this.username,
    required this.joinedCount,
    required this.phone,
    required this.isMale,
  });
  final String id;
  final String username;
  final String nickname;
  final String avatarUrl;
  final int joinedCount;
  final String phone;
  final bool isMale;

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    final String avatarUrl = "http://10.1.4.13:1337${json['avatarUrl']}";
    return UserInfo(
      id: json['id'].toString(),
      nickname: json['nickname'],
      avatarUrl: avatarUrl,
      username: json['username'],
      joinedCount: json['joined'] ?? 0,
      phone: json['phone'],
      isMale: json['isMale'],
    );
  }
}
