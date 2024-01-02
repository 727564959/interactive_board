import 'package:dio/dio.dart';
import '../../../common.dart';
import 'player.dart';
import '../../../data/network/show_repository.dart';

class PlayerApi {
  static PlayerApi? _instance;
  factory PlayerApi() => _instance ?? PlayerApi._internal();
  final dio = Dio();
  final showRepository = GameShowRepository();
  final baseUrl = "http://10.0.0.4:1337/api";
  PlayerApi._internal() {
    _instance = this;
  }

  Future<List<PlayerInfo>> fetchPlayers() async {
    final response = await dio.get(
      "$baseUrl/shows/${showRepository.showId}/players",
      queryParameters: {
        "tableId": Global.tableId,
        "bJoinedCount": true,
      },
    );
    List players = response.data;
    print(players);
    return players.map((player) => PlayerInfo.fromJson(player)).toList();
  }

  Future<void> updatePosition(int position, int? playerId) async {
    await dio.post(
      "$baseUrl/rounds/${showRepository.roundId}/update-positions",
      data: {
        "playerId": playerId,
        "position": position,
      },
    );
  }
}
