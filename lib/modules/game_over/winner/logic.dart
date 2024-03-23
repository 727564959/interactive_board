import 'dart:convert';

import 'package:get/get.dart';

import '../../../data/model/show_state.dart';
import 'data/winner_api.dart';

class WinnerLogic extends GetxController {
  final winnerApi = WinnerApi();

  String get gameName => ((Get.arguments as ShowState).details as GamingDetails).game;

  @override
  void onInit() async {
    super.onInit();
  }
}
