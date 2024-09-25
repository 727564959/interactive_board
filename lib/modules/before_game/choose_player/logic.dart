import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:interactive_board/app_routes.dart';
import 'package:interactive_board/common.dart';
import 'package:interactive_board/data/model/show_state.dart';
import 'package:interactive_board/mirra_style.dart';

import 'package:socket_io_client/socket_io_client.dart';

import 'data/player.dart';
import 'data/player_api.dart';

class ChoosePlayerLogic extends GetxController with GetTickerProviderStateMixin {
  final playerApi = PlayerApi();
  List<PlayerInfo> players = [];
  FToast fToast = FToast();
  final ShowState showState = Get.arguments;
  String get game => (showState.details as GamingDetails).game;
  Timer? _timer;
  Timer? _selectedPlayerErrorTimer;
  int get showId => showState.showId!;
  GamingDetails get showInfo => showState.details;
  String get mode => showInfo.mode;

  final Map<int, PlayerInfo?> optionalPositions = {};
  bool get bSelectComplete => optionalPositions.values.every((element) => element != null);
  late final Socket positionSocket;

  int get selectedCount {
    int result = 0;
    for (final player in players) {
      if (optionalPositions.values.any((element) => player.id == element?.id)) {
        result++;
      }
    }
    return result;
  }

  List<PlayerInfo> get unselectedPlayers {
    final result = <PlayerInfo>[];
    for (final player in players) {
      if (!optionalPositions.values.any((element) => player.id == element?.id)) {
        result.add(player);
      }
    }
    return result;
  }

  bool get bAlreadyJoined {
    for (final player in players) {
      if (optionalPositions.values.any((element) => player.id == element?.id)) {
        return true;
      }
    }
    return false;
  }

  List<PlayerInfo> bottomBarPlayers = [];

  int? selectedPosition;

  bool bShowPlayerSelectException = false;

  late final animationController = AnimationController(vsync: this, duration: 400.ms)..addListener(() => update());

  late final delayController = AnimationController(vsync: this, duration: 350.ms)..addListener(() => update());

  @override
  void onInit() async {
    super.onInit();
    fToast.init(Get.context!);
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
    } else if (mode == 'free-8') {
      optionalPositions.addAll({1: null, 2: null, 3: null, 4: null, 5: null, 6: null, 7: null, 8: null});
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
    _selectedPlayerErrorTimer?.cancel();
    super.onClose();
  }

  Future<void> updatePosition(int? playerId) async {
    final position = selectedPosition!;
    final player = players.firstWhere((element) => element.id == playerId);
    await playerApi.updatePosition(showInfo.roundId, position, playerId);
    optionalPositions[position] = player;
    selectedPosition = null;
    update();
    resetJumpTimer();
  }

  Future<void> removePlayer(int position) async {
    fToast.removeCustomToast();
    bShowPlayerSelectException = false;
    selectedPosition = position;
    await playerApi.updatePosition(showInfo.roundId, position, null);
    resetJumpTimer();
    update();
  }

  Future<void> showBottomBar(int position) async {
    await removePlayer(position);
    players = await playerApi.fetchPlayers(showId);
    bottomBarPlayers = List.of(unselectedPlayers);
    delayController.reset();
    Future.delayed(100.ms).then((value) => delayController.forward());
    animationController.forward();
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

  void showPlayerSelectException() async {
    fToast.showToast(
      gravity: ToastGravity.CENTER,
      toastDuration: 3.seconds,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xff7b7b7b),
        ),
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              MirraIcons.getGameShowIconPath("toast_warn.png"),
              width: 50.w,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(width: 10.w),
            Text(
              "Can’t change players from other squad",
              style: CustomTextStyles.title5(color: Colors.white, fontSize: 35.sp),
            ),
          ],
        ),
      ),
    );
    bShowPlayerSelectException = true;
    update();
    _selectedPlayerErrorTimer?.cancel();
    _selectedPlayerErrorTimer = Timer(3.seconds, () {
      bShowPlayerSelectException = false;
      update();
    });
  }
}
