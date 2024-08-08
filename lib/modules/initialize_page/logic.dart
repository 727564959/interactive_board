import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:interactive_board/data/network/process_controller.dart';

import '../../app_routes.dart';
import '../../common.dart';

import 'package:flutter_udid/flutter_udid.dart';
import 'data.dart';

class InitializeLogic extends GetxController {
  final processController = ProcessController();
  final deviceId = "".obs;
  final udid = "".obs;
  final dio = Dio();
  late final BoardInfo board;
  @override
  void onInit() async {
    super.onInit();
    udid.value = await FlutterUdid.udid;
    final response = await dio.post(
      "$basePayloadApiUrl/board-configs/register",
      data: {"udid": udid.value},
    );
    board = BoardInfo.fromJsom(response.data);
    deviceId.value = board.id;
    if (!board.bChecked) return;

    if (board.type == "interact" && board.tableId != null) {
      Global.setTableId(board.tableId!);
      processController.listeningEvents();
    } else if (board.type == "check_in" && board.tableId != null) {
      Global.setTableId(board.tableId!);
      Get.offAllNamed(AppRoutes.landingPage);
    }
  }
}
