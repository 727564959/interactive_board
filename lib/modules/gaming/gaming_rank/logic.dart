import 'package:get/get.dart';
import 'package:interactive_board/app_routes.dart';
import 'package:interactive_board/data/model/show_state.dart';
import 'package:synchronized/synchronized.dart';

import '../../../../common.dart';
import 'data/player.dart';
import 'data/player_records_repository.dart';

class GamingRankLogic extends GetxController {
  String get gameName => (Get.arguments as ShowState).game;
  late RecordsRepository recordsRepository;
  bool bGameStart = false;
  final List<PlayerRecord> playerRecords = [];
  final lock = Lock();
  List<PlayerRecord> get sortedRecords => List<PlayerRecord>.of(playerRecords)..sort((a, b) => b.score - a.score);
  List<PlayerInfo> get showPlayers {
    try {
      final selectedPlayer = playerRecords.firstWhere((e) => e.player.id == selectedId);
      return [selectedPlayer.player];
    } on StateError {
      final team = Global.team;
      return playerRecords.map((e) => e.player).where((e) {
        final playerTeam = e.position < 5 ? 0 : 1;
        return playerTeam == team;
      }).toList()
        ..sort((a, b) => a.position - b.position);
    }
  }

  int? selectedId;
  void clickItem(int id) {
    if (id == selectedId) {
      selectedId = null;
    } else {
      selectedId = id;
    }
    update(["player_card", "leaderboard"]);
  }

  @override
  void onInit() async {
    super.onInit();
    recordsRepository = RecordsRepository(onGamingUpdate: (payload) async {
      if (bGameStart == false) {
        bGameStart = true;
        update(["mask"]);
      }

      for (final item in payload) {
        final int position = item['position'];
        final int playerId = item['playerId'];
        final int score = item['score'];
        lock.synchronized(() async {
          final i = playerRecords.indexWhere((e) => e.player.id == playerId);
          if (i == -1) {
            final player = await recordsRepository.fetchPlayerInfo(playerId, position);
            final record = PlayerRecord(player: player, score: score);
            playerRecords.add(record);
            update(["player_card", "leaderboard"]);
          } else {
            playerRecords[i].score = score;
            update(["leaderboard"]);
          }
        });
      }
    }, onGameOver: () {
      Get.offAllNamed(AppRoutes.gameOver, arguments:  Get.arguments);
    });
  }

  @override
  void onClose() {
    recordsRepository.dispose();
    super.onClose();
  }
}
