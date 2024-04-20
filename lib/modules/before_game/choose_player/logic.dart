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
  // ShowState get showState => Get.arguments;
  ShowState get showState => ShowState.fromJson({
        "showId": 13,
        "status": "game_preparing",
        "details": {
          "showId": 13,
          "roundId": 26,
          "roundNumber": 1,
          "mode": "normal",
          "game": "Block Party",
          "customers": [
            {"tableId": 4, "consumerId": 259},
            {"tableId": 1, "consumerId": 267}
          ],
          "teams": []
        }
      });
  int get showId => showState.showId!;
  GamingDetails get showInfo => showState.details;
  String get mode => showInfo.mode;

  final Map<int, PlayerInfo?> optionalPositions = {};
  bool get bSelectComplete => optionalPositions.values.every((element) => element != null);
  late final Socket positionSocket;

  List<PlayerInfo> get unselectedPlayers {
    final result = <PlayerInfo>[];
    for (final player in players) {
      if (!optionalPositions.values.any((element) => player.id == element?.id)) {
        result.add(player);
      }
    }
    return result;
  }

  int? selectedPosition;

  @override
  void onInit() async {
    super.onInit();
    final option = OptionBuilder().setTransports(['websocket']).disableAutoConnect().enableForceNew().build();
    positionSocket = io('$baseSocketIoUrl/listener/position', option);
    positionSocket.on('position_update', (data) {
      final int position = data['position'];
      if (!optionalPositions.containsKey(position)) return;
      final player = PlayerInfo.fromJson(data['player'], data['tableId']);
      if (optionalPositions[position]?.id == player.id) return;
      optionalPositions[position] = player;
      update();
    });

    positionSocket.on('position_remove', (data) {
      final int position = data['position'];
      if (!optionalPositions.containsKey(position)) return;
      if (optionalPositions[position] == null) return;
      optionalPositions[position] = null;
      update();
    });
    positionSocket.connect();

    final tableId = Global.tableId;
    if (mode == 'event') {
      optionalPositions[tableId * 2 - 1] = null;
    } else if (mode == 'normal') {
      optionalPositions[tableId * 2 - 1] = null;
      optionalPositions[tableId * 2] = null;
    } else if (mode == 'free-4') {
      optionalPositions.addAll({1: null, 2: null, 5: null, 6: null});
    }
    updateAllPositions();
  }

  void updateAllPositions() async {
    players = await playerApi.fetchPlayers(showId);
    final positions = await playerApi.fetchPositions(showInfo.roundId);
    for (final item in positions) {
      if (!optionalPositions.containsKey(item.position)) continue;
      optionalPositions[item.position] = item.player;
    }
    update();
  }

  @override
  void onClose() {
    positionSocket.close();
    super.onClose();
  }

  void updatePosition(int? playerId) async {
    final position = selectedPosition!;
    final player = players.firstWhere((element) => element.id == playerId);
    try {
      await playerApi.updatePosition(showInfo.roundId, position, playerId);
      optionalPositions[position] = player;
      selectedPosition = null;
      update();
    } on StateError {
      return;
    } on DioException {
      return;
    }
  }

  void removePlayer(position) {
    optionalPositions[position] = null;
    try {
      playerApi.updatePosition(showInfo.roundId, position, null);
    } on DioException {
      updatePlayerInfo();
    }
  }

  void updatePlayerInfo() async {
    players = await playerApi.fetchPlayers(showInfo.showId);
    for (final position in optionalPositions.keys) {
      if (optionalPositions[position] == null) continue;
      final playerId = optionalPositions[position]!.id;
      final player = players.firstWhere((element) => element.id == playerId);
      optionalPositions[position] = player;
    }
    update();
  }

  void showBottomBar(int position) {
    selectedPosition = position;
    update();
  }

  void dismissBottomBar() {
    selectedPosition = null;
    update();
  }
}
