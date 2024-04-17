class PlayerBar {
  PlayerBar(
      {required this.id,
      required this.nickname,
      required this.avatarUrl,
      required this.rank,
      required this.score,
      required this.tableId,
      required this.playerId,
      required this.position,});

  final String id;
  final String nickname;
  final String avatarUrl;
  final int rank;
  final int score;
  final int tableId;
  final int playerId;
  final int position;
}