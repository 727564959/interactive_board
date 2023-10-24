import 'package:dio/dio.dart';
import 'game_records.dart';
import '../../../data/network/show_repository.dart';

class GameRecordsApi {
  static GameRecordsApi? _instance;
  factory GameRecordsApi() => _instance ?? GameRecordsApi._internal();
  final dio = Dio();
  final showRepository = GameShowRepository();
  final baseUrl = "http://10.1.4.13:1337/api/game-show";
  GameRecordsApi._internal() {
    _instance = this;
  }

  Future<List<GameRecords>> fetchRecords() async {
    final response = await dio.get(
      "$baseUrl/round/records",
      queryParameters: {"roundId": showRepository.roundId},
    );
    List teamScore = response.data['teamScore'];
    return teamScore.map((item) => GameRecords.fromJson(item)).toList();
  }
}
