class SettlementInfo {
  SettlementInfo(
      {required this.username,
      required this.nickname,
      required this.tableId,
      required this.avatarUrl,
      required this.team,
      required this.position,
      required this.rank,
      required this.score});

  final String username;
  final String nickname;
  final int tableId;
  final String avatarUrl;
  final int team;
  final int position;
  final int rank;
  final int score;
}
