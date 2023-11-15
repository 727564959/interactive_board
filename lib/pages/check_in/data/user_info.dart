import 'avatar_info.dart';

class UserInfo {
  UserInfo({
    required this.id,
    required this.nickname,
    required this.avatar,
    required this.username,
    required this.isMale,
  });
  final String id;
  final String username;
  final String nickname;
  final AvatarInfo avatar;
  final bool isMale;

  factory UserInfo.fromStrapiJson(Map<String, dynamic> json) {
    print(json);
    final String avatarUrl = "http://10.1.4.13:1337${json['avatarUrl']}";
    final headgear = json['headgear'];
    final avatar = AvatarInfo(
      id: headgear['id'].toString(),
      name: headgear['name'],
      url: headgear['avatar']["formats"]["thumbnail"]['url'],
    );
    return UserInfo(
      id: json['id'].toString(),
      nickname: json['nickname'],
      avatar: avatar,
      username: json['username'],
      isMale: json['isMale'],
    );
  }

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    final String avatarUrl = "http://10.1.4.13:1337${json['avatarUrl']}";
    final avatar = AvatarInfo(
      id: json['headgearId'].toString(),
      name: json['headgearName'],
      url: avatarUrl,
    );
    return UserInfo(
      id: json['id'].toString(),
      nickname: json['nickname'],
      avatar: avatar,
      username: json['username'],
      isMale: json['isMale'],
    );
  }
}
