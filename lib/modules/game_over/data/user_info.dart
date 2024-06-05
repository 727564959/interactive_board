import '../../../../common.dart';

class UserInfo {
  UserInfo({
    required this.id,
    required this.nickname,
    required this.avatarUrl,
    required this.headgearId,
    required this.headgearName,
    required this.skinColor,
    required this.sex,
    required this.joinedCount,
    required this.tableId,
  });
  final int id;
  final String nickname;
  final String avatarUrl;
  final String headgearId;
  final String headgearName;
  final String skinColor;
  final String sex;
  final int joinedCount;
  final int tableId;

  factory UserInfo.fromJson(Map<String, dynamic> json, int tableId) {
    final gameResource = json['gameResource'];
    final String avatarUrl = "$baseStrapiUrl${json['avatarUrl']}";
    return UserInfo(
      id: json['id'],
      nickname: json['nickname'],
      avatarUrl: avatarUrl,
      headgearId: gameResource['headgearId'].toString(),
      headgearName: gameResource['headgearName'],
      skinColor: gameResource['skinColor'],
      sex: gameResource['sex'],
      joinedCount: json['joinedCount'] ?? 0,
      tableId: tableId,
    );
  }
}

class PositionInfo {
  PositionInfo({required this.player, required this.position});
  UserInfo player;
  int position;
}
