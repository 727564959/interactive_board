import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:interactive_board/common.dart';
import 'package:interactive_board/data/model/show_state.dart';

import 'package:socket_io_client/socket_io_client.dart';

import 'data/player.dart';
import 'data/player_api.dart';

class ChoosePlayerLogic extends GetxController {
  final playerApi = PlayerApi();
  List<PlayerInfo> players = [];
  ShowState get showState => Get.arguments;
  get showId => showState.showId;
  get showInfo => showState.details as GamingDetails;

  final Map<int, PlayerInfo?> selectedPlayers = {};
  bool get bSelectComplete => selectedPlayers.values.every((element) => element != null);
  late final Socket positionSocket;

  List<PlayerInfo> get unselectedPlayers {
    final result = <PlayerInfo>[];
    for (final player in players) {
      if (!selectedPlayers.values.any((element) => player.id == element?.id)) {
        result.add(player);
      }
    }
    return result;
  }

  @override
  void onInit() async {
    super.onInit();
    final option = OptionBuilder().setTransports(['websocket']).disableAutoConnect().enableForceNew().build();
    positionSocket = io('$baseSocketIoUrl/listener/position', option);
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
    positionSocket.connect();

    final tableId = Global.tableId;
    final mode = showInfo.mode;
    if (mode == 'event') {
      selectedPlayers[tableId] = null;
    } else if (mode == 'normal') {
      selectedPlayers[tableId * 2 - 1] = null;
      selectedPlayers[tableId * 2] = null;
    } else if (mode == 'free-4') {
      selectedPlayers.addAll({2: null, 3: null, 6: null, 7: null});
    } else if (mode == 'free-8') {
      selectedPlayers.addAll({1: null, 2: null, 3: null, 4: null, 5: null, 6: null, 7: null, 8: null});
    }

    updateAllPositions();
  }

  void updateAllPositions() async {
    players = await playerApi.fetchPlayers(showId);
    final positions = await playerApi.fetchPositions(showInfo.roundId);
    for (final item in positions) {
      if (!selectedPlayers.containsKey(item.position)) continue;
      selectedPlayers[item.position] = item.player;
    }
    update();
  }

  @override
  void onClose() {
    positionSocket.close();
    super.onClose();
  }

  void updatePosition(int position, int? playerId) {
    final player = players.firstWhere((element) => element.id == playerId);
    selectedPlayers[position] = player;
    update();
    try {
      playerApi.updatePosition(showInfo.roundId, position, playerId);
    } on StateError {
      return;
    } on DioException {
      updatePlayerInfo();
    }
  }

  void removePlayer(position) {
    selectedPlayers[position] = null;
    try {
      playerApi.updatePosition(showInfo.roundId, position, null);
    } on DioException {
      updatePlayerInfo();
    }
  }

  void updatePlayerInfo() async {
    players = await playerApi.fetchPlayers(showInfo.showId);
    for (final position in selectedPlayers.keys) {
      if (selectedPlayers[position] == null) continue;
      final playerId = selectedPlayers[position]!.id;
      final player = players.firstWhere((element) => element.id == playerId);
      selectedPlayers[position] = player;
    }
    update();
  }
}
