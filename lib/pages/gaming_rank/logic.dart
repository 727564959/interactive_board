import 'package:get/get.dart';
import '../../data/network/show_repository.dart';
import '../../common.dart';
import 'data/player.dart';

class GamingRankLogic extends GetxController {
  String get gameName => GameShowRepository().gameName!;
  final List<PlayerRecord> playerRecords = [
    PlayerRecord(
        player: PlayerInfo(
          id: '1',
          nickname: 'abc',
          avatarUrl: 'http://10.1.4.13:1337/uploads/_829c27769b.png',
          username: 'rthrha',
          position: 1,
        ),
        score: 1775),
    PlayerRecord(
        player: PlayerInfo(
          id: '2',
          nickname: 'a1232bc',
          avatarUrl: 'http://10.1.4.13:1337/uploads/_b8b7eb77d2.png',
          username: 'rthrht',
          position: 2,
        ),
        score: 1233),
    PlayerRecord(
        player: PlayerInfo(
          id: '3',
          nickname: 'a5bc',
          avatarUrl: 'http://10.1.4.13:1337/uploads/_209cf9df64.png',
          username: 'hrhrt',
          position: 3,
        ),
        score: 75),
    PlayerRecord(
        player: PlayerInfo(
          id: '4',
          nickname: 'asfaf',
          avatarUrl: 'http://10.1.4.13:1337/uploads/_72f56cc637.png',
          username: 'thtrh',
          position: 6,
        ),
        score: 775),
  ];
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
      }).toList();
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
  }
}
