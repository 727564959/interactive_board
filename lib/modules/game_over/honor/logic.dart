import 'dart:convert';

import 'package:get/get.dart';

import '../../../data/model/show_state.dart';
import 'data/honor_api.dart';

class HonorLogic extends GetxController {
  final honorApi = HonorApi();

  String get gameName => ((Get.arguments as ShowState).details as GamingDetails).game;

  @override
  void onInit() async {
    super.onInit();
  }
}
