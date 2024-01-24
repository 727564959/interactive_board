import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:interactive_board/common.dart';

import 'package:socket_io_client/socket_io_client.dart';

import 'data/player.dart';
import 'data/player_api.dart';
import '../../data/network/show_repository.dart';

class ChoosePlayerLogic extends GetxController {
  final playerApi = PlayerApi();
  List<PlayerInfo> players = [];
  String get gameName => GameShowRepository().gameName!;
  String get showMode => GameShowRepository().mode!;
  int get round => GameShowRepository().currentRound;
  final Map<int, PlayerInfo?> selectedPlayers = {};
  bool get bSelectComplete => selectedPlayers.values.every((element) => element != null);
  final baseUrl = 'http://10.1.4.16:12333';
  late final Socket positionSocket;

  @override
  void onInit() async {
    super.onInit();
    // Global.setTableId(3);
    final tableId = Global.tableId;
    if (showMode == 'event') {
      selectedPlayers[tableId] = null;
    } else if (showMode == 'normal' && round % 2 == tableId % 2) {
      if (tableId % 2 == 1) {
        selectedPlayers[tableId] = null;
        selectedPlayers[tableId + 1] = null;
      } else {
        selectedPlayers[tableId - 1] = null;
        selectedPlayers[tableId] = null;
      }
    } else if (showMode == 'free-4') {
      selectedPlayers.addAll({2: null, 3: null, 6: null, 7: null});
    } else if (showMode == 'free-8') {
      selectedPlayers.addAll({1: null, 2: null, 3: null, 4: null, 5: null, 6: null, 7: null, 8: null});
    }

    players = await playerApi.fetchPlayers();
    final positions = await playerApi.fetchPositions();
    for (final item in positions) {
      if (!selectedPlayers.containsKey(item.position)) return;
      selectedPlayers[item.position] = item.player;
    }
    update();

    final option = OptionBuilder().setTransports(['websocket']).build();
    positionSocket = io('$baseUrl/listener/position', option);
    positionSocket.on('position_update', (data) {
      final int position = data['position'];
      if (!selectedPlayers.containsKey(position)) return;
      final player = PlayerInfo.fromJson(data['player'], data['tableId']);
      if (selectedPlayers[position]?.id == player.id) return;
      selectedPlayers[position] = player;
      update();
    });

    positionSocket.on('position_remove', (data) {
      final int position = data['position'];
      if (!selectedPlayers.containsKey(position)) return;
      if (selectedPlayers[position] == null) return;
      selectedPlayers[position] = null;
      update();
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
      if (!selectedPlayers.values.any((element) => player.id == element?.id)) {
        result.add(player);
      }
    }
    return result;
  }

  void updatePosition(int position, int? playerId) {
    final player = players.firstWhere((element) => element.id == playerId);
    selectedPlayers[position] = player;
    update();
    try {
      playerApi.updatePosition(position, playerId);
    } on StateError {
      return;
    } on DioException {
      updatePlayerInfo();
    }
  }

  void removePlayer(position) {
    selectedPlayers[position] = null;
    try {
      playerApi.updatePosition(position, null);
    } on DioException {
      updatePlayerInfo();
    }
  }

  void updatePlayerInfo() async {
    players = await playerApi.fetchPlayers();
    for (final position in selectedPlayers.keys) {
      if (selectedPlayers[position] == null) continue;
      final playerId = selectedPlayers[position]!.id;
      final player = players.firstWhere((element) => element.id == playerId);
      selectedPlayers[position] = player;
    }
    update();
  }
}
