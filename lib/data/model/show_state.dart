class ShowState {
  ShowState({
    required this.showId,
    required this.roundId,
    required this.roundNumber,
    required this.mode,
    required this.game,
  });
  final int showId;
  final int roundNumber;
  final int roundId;
  final String game;
  final String mode;
  factory ShowState.fromJson(Map<String, dynamic> json) {
    return ShowState(
      showId: json['showId'],
      roundId: json['roundId'],
      roundNumber: json['currentRound'],
      mode: json["mode"],
      game: json['game'],
    );
  }
}
