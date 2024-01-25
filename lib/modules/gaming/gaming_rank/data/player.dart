import 'package:interactive_board/common.dart';

class PlayerInfo {
  PlayerInfo({
    required this.id,
    required this.nickname,
    required this.avatarUrl,
    required this.position,
  });
  final int id;

  final String nickname;
  final String avatarUrl;
  final int position;

  factory PlayerInfo.fromJson(Map<String, dynamic> json) {
    final String avatarUrl = "$baseStrapiUrl${json['avatarUrl']}";
    return PlayerInfo(
      id: json['id'],
      nickname: json['nickname'],
      avatarUrl: avatarUrl,
      position: json['position'],
    );
  }
}

class PlayerRecord {
  PlayerRecord({required this.player, this.score = 0});
  final PlayerInfo player;
  int score;
}
