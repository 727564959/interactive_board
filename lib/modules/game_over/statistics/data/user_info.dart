import '../../../../common.dart';

class UserInfo {
  UserInfo({
    required this.id,
    required this.nickname,
    required this.avatarUrl,
  });
  final String id;
  final String nickname;
  final String avatarUrl;

  factory UserInfo.fromStrapiJson(Map<String, dynamic> json) {
    final headgear = json['gameResource'];
    final String avatarUrl = "$baseStrapiUrl${headgear['avatar']["formats"]["thumbnail"]['url']}";

    return UserInfo(
      id: json['id'].toString(),
      nickname: json['nickname'],
      avatarUrl: avatarUrl,
    );
  }

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    final String avatarUrl = "$baseStrapiUrl${json['avatarUrl']}";
    return UserInfo(
      id: json['id'].toString(),
      nickname: json['nickname'],
      avatarUrl: avatarUrl,
    );
  }
}
