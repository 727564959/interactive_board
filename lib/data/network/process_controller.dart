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
  final _dio = Dio();

  Future<ShowState> fetchShowState() async {
    final response = await _dio.get("http://$baseApiUrl/show/state");
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
      final state = ShowState.fromJson(data);
      if (state.status == ShowStatus.waiting) {
        Get.offAllNamed(AppRoutes.takeARest);
      }
      if (state.status == ShowStatus.gamePreparing) {
        Get.offAllNamed(AppRoutes.choosePlayer, arguments: state);
      }
      if (state.status == ShowStatus.showPreparing) {
        Get.offAllNamed(AppRoutes.checkIn, arguments: state);
      }
    });
    _showSocket.on('start_show', (data) async {
      final state = ShowState.fromJson(data);
      Get.offAllNamed(AppRoutes.choosePlayer, arguments: state);
    });

    _showSocket.on('stop_show', (data) async {
      final state = ShowState.fromJson(data);
      Get.offAllNamed(AppRoutes.takeARest);
    });

    _showSocket.on('publish_show', (data) async {
      final state = ShowState.fromJson(data);
      Get.offAllNamed(AppRoutes.checkIn, arguments: state);
    });
    _showSocket.connect();
  }

  void disposeSocketIO() {
    // _quizSocket.close();
    _showSocket.close();
  }

  ProcessController._internal() {
    _instance = this;
  }
}
