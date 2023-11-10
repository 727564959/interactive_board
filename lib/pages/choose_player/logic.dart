import 'package:get/get.dart';
import 'data/player.dart';
import 'data/player_api.dart';
import '../../data/network/show_repository.dart';
import '../../common.dart';

class ChoosePlayerLogic extends GetxController {
  final playerApi = PlayerApi();
  List<PlayerInfo> players = [];
  String get gameName => GameShowRepository().gameName!;
  final selectedPlayers = List<PlayerInfo?>.generate(4, (index) => null);
  bool get bSelectComplete => selectedPlayers.every((element) => element != null);

  //3、4、5、6桌坐人，每桌上两人
  int getPosition(int index) {
    return (Global.team == 0 ? 1 : 5) + index;
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
    update(["countdown"]);
    playerApi.updatePosition(username, getPosition(index));
  }

  void removePlayer(index) {
    selectedPlayers[index] = null;
    playerApi.clearPosition(getPosition(index));
    update(["countdown"]);
  }
}
