import 'package:get/get.dart';
import 'data/player.dart';
import 'data/player_api.dart';
import '../../data/network/show_repository.dart';
import '../../common.dart';

class ChoosePlayerLogic extends GetxController {
  final playerApi = PlayerApi();
  List<PlayerInfo> players = [];
  String get gameName => GameShowRepository().gameName!;
  final selectedPlayers = List<PlayerInfo?>.generate(2, (index) => null);

  //3、4、5、6桌坐人，每桌上两人
  int getPosition(int index) {
    return (Global.tableId - 3) * 2 + index + 1;
  }

  @override
  void onInit() async {
    super.onInit();
    players = await playerApi.fetchPlayers();
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
    playerApi.updatePosition(username, getPosition(index));
  }

  void removePlayer(index) {
    selectedPlayers[index] = null;
    playerApi.clearPosition(getPosition(index));
  }
}
