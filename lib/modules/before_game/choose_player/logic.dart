import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/app_routes.dart';
import 'package:interactive_board/common.dart';
import 'package:interactive_board/data/model/show_state.dart';

import 'package:socket_io_client/socket_io_client.dart';

import '../confirm_selection/view.dart';
import 'data/player.dart';
import 'data/player_api.dart';

class ChoosePlayerLogic extends GetxController with GetTickerProviderStateMixin {
  final playerApi = PlayerApi();
  List<PlayerInfo> players = [];
  // ShowState get showState => ShowState.fromJson({
  //       "showId": 22,
  //       "status": "game_preparing",
  //       "details": {
  //         "showId": 22,
  //         "roundId": 47,
  //         "roundNumber": 1,
  //         "mode": "normal",
  //         "game": "Treasure Dash",
  //         "customers": [
  //           {"tableId": 2, "consumerId": 274},
  //           {"tableId": 3, "consumerId": 274},
  //           {"tableId": 4, "consumerId": 302}
  //         ],
  //         "teams": [
  //           {
  //             "name": "RABBIT",
  //             "teamId": 4,
  //             "iconPath": "/uploads/small_4_1_60b4f861f0.png",
  //             "blackBorderIconPath": "/uploads/small_4_d_98061c3869.png"
  //           }
  //         ]
  //       }
  //     });
  final ShowState showState = Get.arguments;
  String get game => (showState.details as GamingDetails).game;
  Timer? _timer;
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

  List<PlayerInfo> bottomBarPlayers = [];

  int? selectedPosition;

  late final animationController = AnimationController(vsync: this, duration: 400.ms)..addListener(() => update());

  late final delayController = AnimationController(vsync: this, duration: 350.ms)..addListener(() => update());

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
      resetJumpTimer();
    });

    positionSocket.on('position_remove', (data) {
      final int position = data['position'];
      if (!optionalPositions.containsKey(position)) return;
      if (optionalPositions[position] == null) return;
      optionalPositions[position] = null;
      update();
      resetJumpTimer();
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

  void resetJumpTimer() {
    _timer?.cancel();
    if (!bSelectComplete) return;
    _timer = Timer(3.seconds, () {
      Get.toNamed(AppRoutes.confirmChoicePlayerPage);
    });
  }

  void updateAllPositions() async {
    players = await playerApi.fetchPlayers(showId);
    final positions = await playerApi.fetchPositions(showInfo.roundId);
    for (final item in positions) {
      if (!optionalPositions.containsKey(item.position)) continue;
      optionalPositions[item.position] = item.player;
    }
    update();
    resetJumpTimer();
  }

  @override
  void onClose() {
    positionSocket.close();
    delayController.dispose();
    animationController.dispose();
    _timer?.cancel();
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
      resetJumpTimer();
    } on StateError {
      return;
    } on DioException {
      return;
    }
  }

  Future<void> removePlayer(position) async {
    optionalPositions[position] = null;
    try {
      await playerApi.updatePosition(showInfo.roundId, position, null);
      resetJumpTimer();
      update();
    } on DioException {
      updateAllPositions();
    }
  }

  void showBottomBar(int position) {
    selectedPosition = position;
    delayController.reset();
    Future.delayed(100.ms).then((value) => delayController.forward());
    animationController.forward();
    removePlayer(position).then((value) => bottomBarPlayers = List.of(unselectedPlayers));
    resetJumpTimer();
    update();
  }

  void dismissBottomBar() {
    selectedPosition = null;
    animationController.reverse();
    delayController.stop();
    resetJumpTimer();
    update();
  }

  void cancelTimer() {
    if (_timer == null) return;
    if (!_timer!.isActive) return;
    _timer?.cancel();
  }
}
