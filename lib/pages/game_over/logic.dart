import 'package:get/get.dart';
import 'package:interactive_board/data/model/show_state.dart';
import '../../app_routes.dart';
import 'data/game_records.dart';
import 'data/game_records_api.dart';

import 'dart:math';

enum PageState { winnerText, statistics, glory }

class GameOverLogic extends GetxController {
  final gameRecordsApi = GameRecordsApi();
  List<GameRecords> records = [];
  // List<TeamScore> teamScore = [];
  String teamScore = "";
  ShowState get showState => Get.arguments;
  String get gameName => showState.game;
  int get roundId => showState.roundId;
  int get showId => showState.showId;

  late final int startTimestamp;
  int get countdown =>
      max(0, (startTimestamp - DateTime.now().millisecondsSinceEpoch) ~/ 1000);
  int delayedTime = 5;

  // PageState pageState = PageState.winnerText;
  PageState pageState = PageState.glory;

  @override
  void onInit() async {
    super.onInit();
    records = await gameRecordsApi.fetchRecords(roundId);
    // records = records.sort((a, b) => a.tableId - b.tableId);
    teamScore = await gameRecordsApi.fetchTeamScore(roundId);

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
        // pageState = PageState.glory;
        // update(['page']);
        // this.onInit();
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
