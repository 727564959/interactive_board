class TeamBar {
  TeamBar(
      {
        required this.teamId,
        required this.score,
        required this.rankScore,
        required this.name,
        required this.iconPath,
        required this.blackBorderIconPath,
        required this.rank
      });

  final int teamId;
  final int score;
  final int rankScore;
  final String name;
  final String iconPath;
  final String blackBorderIconPath;
  int rank;
}