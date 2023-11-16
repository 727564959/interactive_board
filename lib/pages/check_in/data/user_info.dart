class UserInfo {
  UserInfo({
    required this.id,
    required this.headgearId,
    required this.nickname,
    required this.avatarUrl,
    required this.username,
    required this.isMale,
  });
  final String id;
  final String username;
  final String nickname;
  final String headgearId;
  final String avatarUrl;
  final bool isMale;

  factory UserInfo.fromStrapiJson(Map<String, dynamic> json) {
    final headgear = json['headgear'];
    final String avatarUrl = "http://10.1.4.13:1337${headgear['avatar']["formats"]["thumbnail"]['url']}";

    return UserInfo(
      id: json['id'].toString(),
      nickname: json['nickname'],
      avatarUrl: avatarUrl,
      username: json['username'],
      isMale: json['isMale'],
      headgearId: headgear['id'].toString(),
    );
  }

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    final String avatarUrl = "http://10.1.4.13:1337${json['avatarUrl']}";
    return UserInfo(
      id: json['id'].toString(),
      nickname: json['nickname'],
      avatarUrl: avatarUrl,
      username: json['username'],
      isMale: json['isMale'],
      headgearId: json['headgearId'].toString(),
    );
  }
}
