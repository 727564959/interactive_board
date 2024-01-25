import 'package:get/get.dart';
import 'logic.dart';

class QuizBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<QuizLogic>(QuizLogic());
  }
}
