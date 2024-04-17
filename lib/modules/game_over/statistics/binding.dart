import 'package:get/get.dart';

import 'logic.dart';

class StatisticsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<StatisticsLogic>(StatisticsLogic());
  }
}