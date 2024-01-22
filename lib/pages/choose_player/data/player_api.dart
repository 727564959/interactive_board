import 'package:dio/dio.dart';
import '../../../common.dart';
import 'player.dart';
import '../../../data/network/show_repository.dart';

class PlayerApi {
  static PlayerApi? _instance;
  factory PlayerApi() => _instance ?? PlayerApi._internal();
  final dio = Dio();
  final showRepository = GameShowRepository();
  final baseUrl = "http://10.1.4.16:1337/api";
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
    return players.map((player) => PlayerInfo.fromJson(player, Global.tableId)).toList();
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
