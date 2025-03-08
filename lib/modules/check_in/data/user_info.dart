import '../../../../common.dart';

class UserAvatar {
  UserAvatar({
    required this.id,
    required this.nickname,
    // required this.avatarUrl,
  });
  final int id;
  final String nickname;
  // final String avatarUrl;

  factory UserAvatar.fromJson(Map<String, dynamic> json) {
    // final String avatarUrl = "$baseStrapiUrl${json['avatarUrl']}";
    return UserAvatar(
      id: json['id'],
      // nickname: json['nickname'],
      // avatarUrl: avatarUrl,avatarUrl,
      nickname: json['firstName'] + " " + json['lastName']
    );
  }
}

class UserInfo {
  UserInfo({
    required this.id,
    required this.nickname,
    required this.avatarUrl,
    required this.headgearId,
    required this.headgearName,
    required this.skinColor,
    required this.sex,
  });
  final int id;
  final String nickname;
  final String avatarUrl;
  final String headgearId;
  final String headgearName;
  final String skinColor;
  final String sex;

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    // final gameResource = json['gameResource'];
    final customization = json['customization'];
    final headgear = json['customization']['headgear'];
    // final String avatarUrl = "$baseStrapiUrl${json['avatarUrl']}";
    return UserInfo(
      id: json['id'],
      nickname: json['firstName'] + " " + json['lastName'],
      avatarUrl: headgear['icon'],
      headgearId: headgear['id'].toString(),
      headgearName: headgear['displayName'],
      skinColor: customization['skinColor']??"",
      sex: customization['sex']??"",
      // avatarUrl: avatarUrl,
      // headgearId: gameResource['headgearId'].toString(),
      // headgearName: gameResource['headgearName'],
      // skinColor: gameResource['skinColor']??"",
      // sex: gameResource['sex']??"",
    );
  }
}
