import '../../../../common.dart';

class PlayerInfo {
  PlayerInfo({
    required this.id,
    required this.nickname,
    required this.avatarUrl,
    required this.tableId,
  });
  final String id;
  final String nickname;
  final String avatarUrl;
  final int tableId;

  factory PlayerInfo.fromJson(Map<String, dynamic> json, int tableId) {
    return PlayerInfo(
      id: json['id'],
      nickname: json['customization']['nickname'],
      avatarUrl: json['customization']['headgear']['icon'],
      tableId: tableId,
    );
  }
}

class PositionInfo {
  PositionInfo({required this.player, required this.position});
  PlayerInfo player;
  int position;
}
