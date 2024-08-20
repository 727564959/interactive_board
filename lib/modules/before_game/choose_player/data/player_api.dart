import 'package:dio/dio.dart';
import '../../../../common.dart';
import 'player.dart';

class PlayerApi {
  static PlayerApi? _instance;
  factory PlayerApi() => _instance ?? PlayerApi._internal();
  final dio = Dio();
  PlayerApi._internal() {
    _instance = this;
  }

  Future<List<PlayerInfo>> fetchPlayers(int showId) async {
    final response = await dio.get(
      "$baseApiUrl/shows/$showId/players",
      queryParameters: {
        "tableId": Global.tableId,
        "bJoinedCount": true,
      },
    );
    List players = response.data;
    return players.map((player) => PlayerInfo.fromJson(player, Global.tableId)).toList();
  }

  Future<List<PositionInfo>> fetchPositions(int roundId) async {
    final response = await dio.get("$baseApiUrl/rounds/$roundId/positions");
    final result = <PositionInfo>[];
    for (final item in response.data) {
      if (!(item as Map).containsKey('tableId')) continue;
      final int tableId = item['tableId'];
      final PlayerInfo player = PlayerInfo.fromJson(item['player'], tableId);
      final int position = item['position'];
      result.add(PositionInfo(player: player, position: position));
    }
    return result;
  }

  Future<void> updatePosition(int roundId, int position, int? playerId) async {
    await dio.post(
      "$baseApiUrl/rounds/$roundId/update-positions",
      data: {
        "tableId": Global.tableId,
        "playerId": playerId,
        "position": position,
      },
    );
  }
}
