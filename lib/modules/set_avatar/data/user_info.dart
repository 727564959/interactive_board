import '../../../common.dart';

class UserInfo {
  UserInfo({
    required this.id,
    required this.nickname,
    required this.avatarUrl,
    required this.headgearId,
    required this.headgearName,
    required this.bodyId,
    required this.bodyName,
  });
  final String id;
  final String nickname;
  final String avatarUrl;
  final String headgearId;
  final String headgearName;
  final String bodyId;
  final String bodyName;

  factory UserInfo.fromStrapiJson(Map<String, dynamic> json) {
    // final headgear = json['headgear'];
    final headgear = json['gameResource'];
    final String avatarUrl = "$baseStrapiUrl${headgear['avatar']["formats"]["thumbnail"]['url']}";

    return UserInfo(
      id: json['id'].toString(),
      nickname: json['nickname'],
      avatarUrl: avatarUrl,
      headgearId: headgear['headgearId'].toString(),
      headgearName: headgear['headgearName'],
      bodyId: headgear['bodyId'].toString(),
      bodyName: headgear['bodyName'],
    );
  }

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    final String avatarUrl = "$baseStrapiUrl${json['avatarUrl']}";
    final headgear = json['gameResource'];
    return UserInfo(
      id: json['id'].toString(),
      nickname: json['nickname'],
      avatarUrl: avatarUrl,
      headgearId: headgear['headgearId'].toString(),
      headgearName: headgear['headgearName'],
      bodyId: headgear['bodyId'].toString(),
      bodyName: headgear['bodyName'],
    );
  }
}
