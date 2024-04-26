import '../../../../common.dart';

class UserInfo {
  UserInfo({
    required this.id,
    required this.nickname,
    required this.avatarUrl,
  });
  final int id;
  final String nickname;
  final String avatarUrl;

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    final String avatarUrl = "$baseStrapiUrl${json['avatarUrl']}";
    return UserInfo(
      id: json['id'],
      nickname: json['nickname'],
      avatarUrl: avatarUrl,
    );
  }
}
