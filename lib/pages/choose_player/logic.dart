import 'dart:convert';

import 'package:get/get.dart';

import 'package:socket_io_client/socket_io_client.dart';

import '../../data/network/utils.dart';
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
  final baseUrl = 'http://10.0.0.4:12333';
  late final Socket positionSocket;

  //3、4、5、6桌坐人，每桌上两人
  int getPosition(int index) {
    return (Global.team == 0 ? 1 : 5) + index;
  }

  @override
  void onInit() async {
    super.onInit();
    players = await playerApi.fetchPlayers();
    final option = OptionBuilder().setTransports(['websocket']).build();
    positionSocket = io('$baseUrl/listener/position', option);
    positionSocket.on('position_state', (data) {
      for (final item in data) {
        final int position = item['position'];
        final index = (position - 1) % 4;
        final int team = position < 5 ? 0 : 1;
        if (team != Global.team) continue;
        final player = PlayerInfo.fromJson(item['player']);
        selectedPlayers[index] = player;
      }
      update();
      update(["countdown"]);
    });
    positionSocket.on('position_update', (data) {
      final int position = data['position'];
      final index = (position - 1) % 4;
      final int team = position < 5 ? 0 : 1;
      if (team != Global.team) return;
      if (data['player'] == null) {
        if (selectedPlayers[index] == null) return;
        selectedPlayers[index] = null;
      } else {
        final player = PlayerInfo.fromJson(data['player']);
        if (selectedPlayers[index]?.id == player.id) return;
        selectedPlayers[index] = player;
      }
      update();
      update(["countdown"]);
    });
  }

  @override
  void onClose() {
    positionSocket.close();
    super.onClose();
  }

  List<PlayerInfo> get unselectedPlayers {
    final result = <PlayerInfo>[];
    for (final player in players) {
      if (!selectedPlayers.any((element) => player.id == element?.id)) {
        result.add(player);
      }
    }
    return result;
  }

  void updatePosition(int index, int? playerId) {
    try {
      final player = players.firstWhere((element) => element.id == playerId);
      selectedPlayers[index] = player;
      update();
      update(["countdown"]);
      playerApi.updatePosition(getPosition(index), playerId);
    } on StateError {
      return;
    }
  }

  void removePlayer(index) {
    selectedPlayers[index] = null;
    playerApi.updatePosition(getPosition(index), null);
    update(["countdown"]);
  }

  void updatePlayerInfo() async {
    players = await playerApi.fetchPlayers();
    for (int i = 0; i < 4; i++) {
      if (selectedPlayers[i] == null) continue;
      final playerId = selectedPlayers[i]!.id;
      final player = players.firstWhere((element) => element.id == playerId);
      selectedPlayers[i] = player;
    }
    update();
  }
}
