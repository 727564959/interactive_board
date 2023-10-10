import 'package:get/get.dart';
import '../../data/network/show_repository.dart';

class GamingRankLogic extends GetxController {
  String get gameName => GameShowRepository().gameName!;

  @override
  void onInit() async {
    super.onInit();
  }
}
