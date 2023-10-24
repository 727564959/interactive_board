import 'package:get/get.dart';
import 'data/game_records.dart';
import 'data/game_records_api.dart';
import '../../data/network/show_repository.dart';

class GameOverLogic extends GetxController {
  final gameRecordsApi = GameRecordsApi();
  List<GameRecords> records = [];
  String get gameName => GameShowRepository().gameName!;
  int get roundId => GameShowRepository().roundId!;
  int get showId => GameShowRepository().showId!;

  @override
  void onInit() async {
    super.onInit();
    records = await gameRecordsApi.fetchRecords();
    update();
  }
}
