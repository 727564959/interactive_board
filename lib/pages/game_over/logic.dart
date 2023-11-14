import 'package:get/get.dart';
import 'data/game_records.dart';
import 'data/game_records_api.dart';
import '../../data/network/show_repository.dart';

import 'dart:math';

enum PageState { winnerText, statistics, glory }

class GameOverLogic extends GetxController {
  final gameRecordsApi = GameRecordsApi();
  List<GameRecords> records = [];
  // List<TeamScore> teamScore = [];
  String teamScore = "";
  String get gameName => GameShowRepository().gameName!;
  int get roundId => GameShowRepository().roundId!;
  int get showId => GameShowRepository().showId!;

  late final int startTimestamp;
  int get countdown =>
      max(0, (startTimestamp - DateTime.now().millisecondsSinceEpoch) ~/ 1000);
  int delayedTime = 5;

  // PageState pageState = PageState.winnerText;
  PageState pageState = PageState.statistics;

  @override
  void onInit() async {
    super.onInit();
    records = await gameRecordsApi.fetchRecords();
    // records = records.sort((a, b) => a.tableId - b.tableId);
    teamScore = await gameRecordsApi.fetchTeamScore();

    print("records logic $records");
    print("teamScore logic $teamScore");

    update(['page']);

    Future.delayed(delayedTime.seconds).then((value) {
      print("delayedTime logic $delayedTime");
      // if (Get.currentRoute == AppRoutes.gameOver) {
      //   Get.offAllNamed(AppRoutes.main);
      // }
      if (pageState == PageState.winnerText) {
        print("跳转 $pageState");
        delayedTime = 10;
        pageState = PageState.statistics;
        update(['page']);
        this.onInit();
      } else if (pageState == PageState.statistics) {
        delayedTime = 10;
        pageState = PageState.glory;
        update(['page']);
        this.onInit();
      } else if (pageState == PageState.glory) {
        print("荣誉展示");
        // delayedTime = 5;
        // pageState = PageState.winnerText;
        // Get.offAllNamed(AppRoutes.main);
      }
      // else if(pageState == PageState.winnerText) {
      //   pageState = PageState.statistics;
      // }
    });
  }

  @override
  void onClose() {
    print("onClose");
    super.onClose();
  }
}
