class RecordsData {
  List<TeamRecord> teamRecords;
  List<PlayerRecord> playerRecords;

  RecordsData({
    required this.teamRecords,
    required this.playerRecords,
  });

  factory RecordsData.fromJson(Map<String, dynamic> json) {
    var teamRecordsData = json['teamRecords'] as List;
    var playerRecordsData = json['playerRecords'] as List;

    List<TeamRecord> teamRecords = teamRecordsData
        .map((team) => TeamRecord(
      teamId: team['teamId'],
      score: team['score'],
      rankScore: team['rankScore'],
    )).toList();

    List<PlayerRecord> playerRecords = playerRecordsData
        .map((player) => PlayerRecord(
      rank: player['rank'],
      score: player['score'],
      tableId: player['tableId'],
      playerId: player['playerId'],
      position: player['position'],
    )).toList();

    return RecordsData(
      teamRecords: teamRecords,
      playerRecords: playerRecords,
    );
  }
}

class TeamRecord {
  int teamId;
  int score;
  int rankScore;

  TeamRecord({
    required this.teamId,
    required this.score,
    required this.rankScore,
  });
}

class PlayerRecord {
  int rank;
  int score;
  int tableId;
  int playerId;
  int position;

  PlayerRecord({
    required this.rank,
    required this.score,
    required this.tableId,
    required this.playerId,
    required this.position,
  });
}
