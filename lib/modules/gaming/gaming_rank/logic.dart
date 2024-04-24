import 'package:get/get.dart';
import 'package:interactive_board/app_routes.dart';
import 'package:interactive_board/data/model/show_state.dart';
import 'package:synchronized/synchronized.dart';

import '../../../../common.dart';
import 'data/player.dart';
import 'data/player_records_repository.dart';

class GamingRankLogic extends GetxController {
  // ShowState get showState => Get.arguments;
  ShowState get showState => ShowState.fromJson({
        "showId": 13,
        "status": "game_preparing",
        "details": {
          "showId": 13,
          "roundId": 27,
          "roundNumber": 2,
          "mode": "normal",
          "game": "Laser Room",
          "customers": [
            {"tableId": 4, "consumerId": 259},
            {"tableId": 1, "consumerId": 267}
          ],
          "teams": [
            {
              "name": "SHARK",
              "teamId": 1,
              "iconPath": "/uploads/small_1_1_9e9ecd8248.png",
              "blackBorderIconPath": "/uploads/small_1_0f327be1b0.png"
            },
            {
              "name": "RABBIT",
              "teamId": 4,
              "iconPath": "/uploads/small_4_1_60b4f861f0.png",
              "blackBorderIconPath": "/uploads/small_4_d_98061c3869.png"
            },
            {
              "name": "PANDA",
              "teamId": 3,
              "iconPath": "/uploads/small_3_1_16a5cfb6e2.png",
              "blackBorderIconPath": "/uploads/small_3_d_af9eac1846.png"
            },
            {
              "name": "PANTHER",
              "teamId": 2,
              "iconPath": "/uploads/small_2_1_a830d6e873.png",
              "blackBorderIconPath": "/uploads/small_2_d_55cb963c79.png"
            }
          ]
        }
      });
  GamingDetails get details => showState.details;
  late RecordsRepository recordsRepository;
  final List<PlayerRecord> playerRecords = [];
  final lock = Lock();
  List<PlayerRecord> get sortedRecords => List<PlayerRecord>.of(playerRecords)..sort((a, b) => b.score - a.score);
  List<PlayerInfo> get showPlayers {
    late final List<int> positions;
    final tableId = Global.tableId;
    final mode = details.mode;
    if (mode == 'event') {
      positions = [tableId * 2 - 1];
    } else if (mode == 'normal') {
      positions = [tableId * 2 - 1, tableId * 2];
    } else {
      positions = [1, 2, 5, 6];
    }
    return playerRecords.map((e) => e.player).where((e) => positions.contains(e.position)).toList();
  }

  @override
  void onInit() async {
    super.onInit();
    recordsRepository = RecordsRepository(onGamingUpdate: (payload) async {
      for (final item in payload) {
        final int position = item['position'];
        final int playerId = item['playerId'];
        final int scores = item['score'];
        lock.synchronized(() async {
          final i = playerRecords.indexWhere((e) => e.player.id == playerId);
          if (i == -1) {
            final player = await recordsRepository.fetchPlayerInfo(playerId, position);
            final record = PlayerRecord(player: player, score: scores);
            playerRecords.add(record);
          } else {
            playerRecords[i].score = scores;
          }
          update();
        });
      }
    }, onGameOver: (data) {
      Get.offAllNamed(AppRoutes.winnerPage, arguments: {"showState": Get.arguments, "records": data});
    });
  }

  @override
  void onClose() {
    recordsRepository.dispose();
    super.onClose();
  }
}
