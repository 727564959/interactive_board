import 'package:dio/dio.dart';
import '../../../common.dart';
import 'player.dart';
import '../../../data/network/show_repository.dart';

class PlayerApi {
  static PlayerApi? _instance;
  factory PlayerApi() => _instance ?? PlayerApi._internal();
  final dio = Dio();
  final showRepository = GameShowRepository();
  final baseUrl = "http://10.1.4.13:1337/api/game-show";
  PlayerApi._internal() {
    _instance = this;
  }

  Future<List<PlayerInfo>> fetchPlayers() async {
    final response = await dio.get(
      "$baseUrl/show/users",
      queryParameters: {"showId": 1, "tableId": Global.tableId},
    );
    List players = response.data['playerList'];
    return players.map((player) => PlayerInfo.fromJson(player)).toList();
  }

  Future<List<PlayerInfo?>> fetchPlayersPosition() async {
    final response = await dio.get(
      "$baseUrl/round/user-positions",
      queryParameters: {"roundId": showRepository.currentRound},
    );
    final result = List<PlayerInfo?>.generate(8, (index) => null);
    for (final item in response.data["playerList"]) {
      final int position = item['position'];
      final player = PlayerInfo.fromJson(item);
      result[position] = player;
    }
    return result;
  }

  Future<void> updatePosition(String username, int position) async {
    await dio.post(
      "$baseUrl/round/user-positions",
      data: {
        "roundId": showRepository.currentRound,
        "username": username,
        "position": position,
      },
    );
  }

  Future<void> clearPosition(int position) async {
    await dio.post(
      "$baseUrl/round/user-positions",
      data: {
        "roundId": showRepository.currentRound,
        "position": position,
      },
    );
  }
}
