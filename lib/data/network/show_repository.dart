import 'package:dio/dio.dart';

class GameShowRepository {
  static GameShowRepository? _instance;
  factory GameShowRepository() => _instance ?? GameShowRepository._internal();
  final dio = Dio();
  final baseUrl = "http://10.1.4.16:1337/api";
  int? showId;
  int? roundId;
  int currentRound = 0;
  String? gameName;
  String? mode;

  GameShowRepository._internal() {
    _instance = this;
    updateShowState();
  }

  Future<void> updateShowState() async {
    final response = await dio.get("$baseUrl/show/state");
    showId = response.data['showId'];
    roundId = response.data['roundId'];
    currentRound = response.data['currentRound'] ?? 0;
    gameName = response.data['game'];
    mode = response.data['mode'];
  }
}
