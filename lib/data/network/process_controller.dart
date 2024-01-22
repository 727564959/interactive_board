import 'package:get/get.dart';
import 'package:interactive_board/app_routes.dart';

import 'show_repository.dart';

import 'package:socket_io_client/socket_io_client.dart';

class ProcessController {
  static ProcessController? _instance;
  factory ProcessController() => _instance ?? ProcessController._internal();
  final baseUrl = 'http://10.1.4.16:12333';
  late final Socket quizSocket;
  late final Socket showSocket;
  final showRepository = GameShowRepository();

  ProcessController._internal() {
    _instance = this;
    final option = OptionBuilder().setTransports(['websocket']).enableReconnection().build();
    quizSocket = io('$baseUrl/listener/quiz', option);
    quizSocket.on('start', (data) {
      Get.offAllNamed(AppRoutes.quiz, arguments: data);
    });
    showSocket = io('$baseUrl/listener/game-show', option);
    showSocket.on('show_starting', (data) async {
      await GameShowRepository().updateShowState();
      Get.offAllNamed(AppRoutes.choosePlayer);
    });
    showSocket.on('waiting_show', (data) async {
      await GameShowRepository().updateShowState();
      Get.offAllNamed(AppRoutes.main);
    });
  }
}
