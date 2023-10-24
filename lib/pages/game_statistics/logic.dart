import 'package:get/get.dart';
import 'data/game_statistics.dart';
import 'data/game_statistics_api.dart';
import '../../data/network/show_repository.dart';

class GameStatisticsLogic extends GetxController {
  final gamestatisticsApi = GameStatisticsApi();
  List<GameStatistics> playerRecords = [];
  String get gameName => GameShowRepository().gameName!;
  int get roundId => GameShowRepository().roundId!;
  int get showId => GameShowRepository().showId!;

  @override
  void onInit() async {
    super.onInit();
    playerRecords = await gamestatisticsApi.fetchStatistics();
    update();
  }
}
