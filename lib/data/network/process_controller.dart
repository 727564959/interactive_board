import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:interactive_board/app_routes.dart';
import 'package:interactive_board/widgets/score_wheel_dialog.dart';
import '../../common.dart';
import 'package:interactive_board/data/model/show_state.dart';

import 'package:socket_io_client/socket_io_client.dart';

import '../../modules/before_game/choose_player/logic.dart';

class ProcessController {
  static ProcessController? _instance;
  factory ProcessController() => _instance ?? ProcessController._internal();
  late final Socket _quizSocket;
  late final Socket _showSocket;
  late final Socket _bonusSocket;
  bool isChecked = false;
  late ShowState state;
  final _dio = Dio();

  Future<ShowState> fetchShowState() async {
    final response = await _dio.get("$baseApiUrl/show/state");
    return ShowState.fromJson(response.data);
  }

  void listeningEvents() {
    final option = OptionBuilder().setTransports(['websocket']).enableReconnection().disableAutoConnect().build();
    _quizSocket = io(baseTriviaUrl, option);
    _quizSocket.on('start', (data) {
      Get.toNamed(AppRoutes.quiz, arguments: data);
    });
    _quizSocket.connect();

    _bonusSocket = io('$baseSocketIoUrl/mini-games/score-wheel', option);
    _bonusSocket.on('show_trigger', (data) {
      if (data["teamId"] != Global.tableId) return;
      Get.dialog(const ScoreWheelDialog(), barrierDismissible: false);
    });
    _bonusSocket.connect();

    _showSocket = io('$baseSocketIoUrl/listener/game-show', option);
    _showSocket.on('show_state', (data) async {
      state = ShowState.fromJson(data);
      if (state.status == ShowStatus.waiting) {
        Get.offAllNamed(AppRoutes.takeARest);
        return;
      }
      isChecked = state.details.customers.any((element) => Global.tableId == element.tableId);
      jumpToPage();
    });

    _showSocket.on('start_show', (data) async {
      state = ShowState.fromJson(data);
      final details = state.details as ShowPreparingDetails;
      isChecked = details.customers.any((element) => Global.tableId == element.tableId);
      if (!isChecked) return;
      Get.offAllNamed(AppRoutes.checkIn, arguments: state);
    });

    _showSocket.on('stop_show', (data) async {
      state = ShowState.fromJson(data);
      isChecked = false;
      Get.offAllNamed(AppRoutes.takeARest);
      // Get.offAllNamed(AppRoutes.showEndPage, arguments: state);
    });

    _showSocket.on('show_complete', (data) async {
      state = ShowState.fromJson(data);
      if (!isChecked) return;
      Get.offAllNamed(AppRoutes.showEndPage, arguments: state);
    });

    _showSocket.on("game_interruption", (data) async {
      state = ShowState.fromJson(data);
      if (!isChecked) return;
      final logic = Get.findOrNull<ChoosePlayerLogic>();
      await Get.offAllNamed(AppRoutes.choosePlayer, arguments: state);
      logic?.updateAllPositions();
    });

    _showSocket.on("choose_player", (data) async {
      state = ShowState.fromJson(data);
      if (!isChecked) return;
      Get.offAllNamed(AppRoutes.choosePlayer, arguments: state);
    });

    _showSocket.on("gaming_time", (data) async {
      state = ShowState.fromJson(data);
      if (!isChecked) return;
      // Get.offAllNamed(AppRoutes.gamingRank, arguments: state);
      print("跳转到gamePlayingPage");
      if (state.details.mode == "free-8") {
        Get.offAllNamed(AppRoutes.freeGamePlayingPage, arguments: {"showState": state, "isWellDone": false});
      } else {
        Get.offAllNamed(AppRoutes.gamePlayingPage, arguments: {"showState": state, "isWellDone": false});
      }
    });

    _showSocket.on("customer_checked", (data) async {
      if (isChecked) return;
      isChecked = data["tableId"] == Global.tableId;
      if (!isChecked) return;
      state = await fetchShowState();
      jumpToPage();
    });
    _showSocket.connect();
  }

  void jumpToPage() {
    if (!isChecked || state.details.mode == "stand-alone") {
      Get.offAllNamed(AppRoutes.takeARest);
      return;
    }
    if (state.status == ShowStatus.choosePlayer) {
      Get.offAllNamed(AppRoutes.choosePlayer, arguments: state);
    } else if (state.status == ShowStatus.gamePreparing) {
      Get.offAllNamed(AppRoutes.checkIn, arguments: state);
    } else if (state.status == ShowStatus.gaming) {
      if (state.details.mode == "free-8") {
        Get.offAllNamed(AppRoutes.freeGamePlayingPage, arguments: {"showState": state, "isWellDone": false});
      } else {
        Get.offAllNamed(AppRoutes.gamePlayingPage, arguments: {"showState": state, "isWellDone": false});
      }
    } else if (state.status == ShowStatus.complete) {
      Get.offAllNamed(AppRoutes.showEndPage, arguments: state);
    } else {
      Get.offAllNamed(AppRoutes.takeARest);
    }
  }

  void disposeSocketIO() {
    _quizSocket.close();
    _showSocket.close();
  }

  ProcessController._internal() {
    _instance = this;
  }
}
