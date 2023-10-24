import 'package:dio/dio.dart';
import 'game_statistics.dart';
import '../../../data/network/show_repository.dart';

class GameStatisticsApi {
  static GameStatisticsApi? _instance;
  factory GameStatisticsApi() => _instance ?? GameStatisticsApi._internal();
  final dio = Dio();
  final showRepository = GameShowRepository();
  final baseUrl = "http://10.1.4.13:1337/api/game-show";
  GameStatisticsApi._internal() {
    _instance = this;
  }

  Future<List<GameStatistics>> fetchStatistics() async {
    final response = await dio.get(
      "$baseUrl/round/records",
      queryParameters: {"roundId": showRepository.roundId},
    );
    List playerRecords = response.data['playerRecords'];
    return playerRecords.map((item) => GameStatistics.fromJson(item)).toList();
  }
}
