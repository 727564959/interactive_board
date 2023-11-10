import 'package:get/get.dart';
import '../../data/network/show_repository.dart';
import '../../common.dart';
import 'data/player.dart';
import 'data/player_records_repository.dart';

class GamingRankLogic extends GetxController {
  String get gameName => GameShowRepository().gameName!;
  late RecordsRepository recordsRepository;
  bool bGameStart = false;
  final List<PlayerRecord> playerRecords = [];
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

  String? selectedId;
  void clickItem(String id) {
    if (id == selectedId) {
      selectedId = null;
    } else {
      selectedId = id;
    }
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    recordsRepository = RecordsRepository(
      onGameStart: () {
        bGameStart = true;
        update();
      },
      onGamingUpdate: (payload) async {
        bGameStart = true;
        for (final item in payload) {
          final int position = item['position'];
          final String username = item['username'];
          final int score = item['score'];
          final i = playerRecords.indexWhere((e) => e.player.username == username);
          if (i == -1) {
            final player = await recordsRepository.fetchPlayerInfo(username, position);
            final record = PlayerRecord(player: player, score: score);
            playerRecords.add(record);
          } else {
            playerRecords[i].score = score;
          }
        }
        update();
      },
    );
  }

  @override
  void onClose() {
    recordsRepository.dispose();
    super.onClose();
  }
}
