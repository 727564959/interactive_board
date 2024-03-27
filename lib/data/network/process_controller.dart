import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:interactive_board/app_routes.dart';
import '../../common.dart';
import 'package:interactive_board/data/model/show_state.dart';

import 'package:socket_io_client/socket_io_client.dart';

class ProcessController {
  static ProcessController? _instance;
  factory ProcessController() => _instance ?? ProcessController._internal();
  late final Socket _quizSocket;
  late final Socket _showSocket;
  bool isChecked = false;
  late ShowState state;
  final _dio = Dio();

  Future<ShowState> fetchShowState() async {
    final response = await _dio.get("$baseApiUrl/show/state");
    return ShowState.fromJson(response.data);
  }

  void listeningEvents() {
    final option = OptionBuilder().setTransports(['websocket']).enableReconnection().disableAutoConnect().build();
    // _quizSocket = io('$baseSocketIoUrl/listener/quiz', option);
    // _quizSocket.on('start', (data) {
    //   Get.toNamed(AppRoutes.quiz, arguments: data);
    // });
    // _quizSocket.connect();

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
      if (!isChecked) return;
      Get.offAllNamed(AppRoutes.choosePlayer, arguments: state);
    });

    _showSocket.on('stop_show', (data) async {
      state = ShowState.fromJson(data);
      isChecked = false;
      Get.offAllNamed(AppRoutes.takeARest);
    });

    _showSocket.on('publish_show', (data) async {
      state = ShowState.fromJson(data);
      final details = state.details as ShowPreparingDetails;
      isChecked = details.customers.any((element) => Global.tableId == element.tableId);
      if (!isChecked) return;
      Get.offAllNamed(AppRoutes.checkIn, arguments: state);
    });

    _showSocket.on("game_interruption", (data) async {
      state = ShowState.fromJson(data);
      if (!isChecked) return;
      Get.offAllNamed(AppRoutes.choosePlayer, arguments: state);
    });

    _showSocket.on("next_round", (data) async {
      state = ShowState.fromJson(data);
      if (!isChecked) return;
      Get.offAllNamed(AppRoutes.choosePlayer, arguments: state);
    });

    _showSocket.on("gaming_time", (data) async {
      state = ShowState.fromJson(data);
      if (!isChecked) return;
      Get.offAllNamed(AppRoutes.gamingRank, arguments: state);
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
    if (!isChecked) {
      Get.offAllNamed(AppRoutes.takeARest);
      return;
    }
    if (state.status == ShowStatus.gamePreparing) {
      Get.offAllNamed(AppRoutes.choosePlayer, arguments: state);
    }
    if (state.status == ShowStatus.showPreparing) {
      Get.offAllNamed(AppRoutes.checkIn, arguments: state);
    }
    if (state.status == ShowStatus.gaming) {
      Get.offAllNamed(AppRoutes.gamingRank, arguments: state);
    }
  }

  void disposeSocketIO() {
    // _quizSocket.close();
    _showSocket.close();
  }

  ProcessController._internal() {
    _instance = this;
  }
}
