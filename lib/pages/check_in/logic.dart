import 'package:get/get.dart';
import '../../data/network/show_repository.dart';
import '../../common.dart';

class CheckInLogic extends GetxController {
  String get gameName => GameShowRepository().gameName!;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
