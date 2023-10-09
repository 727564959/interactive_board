import 'package:get/get.dart';
import '../../data/model/player.dart';
import '../../data/network/player_api.dart';
import '../../data/network/show_repository.dart';

class ChoosePlayerLogic extends GetxController {
  final playerRepository = PlayerApi();
  List<PlayerInfo> players = [];
  String get gameName => GameShowRepository().gameName!;

  final selectedPlayers = List<PlayerInfo?>.generate(4, (index) => null);

  @override
  void onInit() async {
    super.onInit();
    players = await playerRepository.fetchPlayers();
    update();
  }

  List<PlayerInfo> get unselectedPlayers {
    final result = <PlayerInfo>[];
    for (final player in players) {
      if (!selectedPlayers.any((element) => player.username == element?.username)) {
        result.add(player);
      }
    }
    return result;
  }

  void choosePosition(index, username) {
    final player = players.firstWhere((element) => element.username == username);
    selectedPlayers[index] = player;
    update();
  }

  void removePlayer(index) {
    selectedPlayers[index] = null;
  }
}
