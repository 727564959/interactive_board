import 'package:get/get.dart';
import '../../data/model/player.dart';

class ChoosePlayerLogic extends GetxController {
  final players = [
    {"username": "Tom", "nickname": "Tom", "tableId": 5, "avatarUrl": "/uploads/_f56cfd3ac5.png", "joined": 2},
    {"username": "Olivia", "nickname": "Olivia", "tableId": 5, "avatarUrl": "/uploads/_d0aa881ef8.png", "joined": 3},
    {"username": "Paddy", "nickname": "Paddy", "tableId": 5, "avatarUrl": "/uploads/_be4f177098.png", "joined": 1},
    {"username": "Paddy1", "nickname": "Paddy", "tableId": 5, "avatarUrl": "/uploads/_be4f177098.png", "joined": 0},
    {"username": "Paddy2", "nickname": "Paddy", "tableId": 5, "avatarUrl": "/uploads/_be4f177098.png", "joined": 2},
    {"username": "antony", "nickname": "antony", "tableId": 5, "avatarUrl": "/uploads/_b27c81507c.png", "joined": 5}
  ].map((e) => PlayerInfo.fromJson(e)).toList();

  final selectedPlayers = List<PlayerInfo?>.generate(4, (index) => null);

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
