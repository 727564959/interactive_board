import 'package:get/get.dart';
import 'package:interactive_board/data/network/process_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common.dart';

class InitializeLogic extends GetxController {
  final processController = ProcessController();
  @override
  void onInit() async {
    super.onInit();
    final pref = await SharedPreferences.getInstance();
    final tableId = pref.getInt('tableId');
    if (tableId != null) {
      setTableId(tableId);
    }
  }

  Future<void> setTableId(int tableId) async {
    Global.setTableId(tableId);
    processController.listeningEvents();
  }
}
