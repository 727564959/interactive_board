import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../../../common.dart';
import '../check_in/data/skin_gender_option.dart';

class MirraLookLogic extends GetxController {
  int? clickedCard;
  bool isCountdownStart = false;
  String currentName = "";
  SkinOption selectedSkin = SkinOption();
  GenderOption selectedGender = GenderOption();

  final _dio = Dio();

  Future<void> updateUserPreference(int userId, String nickname, int headgearId, String sex, String skinColor) async {
    final response = await _dio.post(
      "$baseApiUrl/players/$userId/update-user-preference",
      data: {
        "nickname": nickname,
        "headgearId": headgearId,
        "sex": sex,
        "skinColor": skinColor,
      },
    );
  }

  @override
  void onInit() async {
    super.onInit();
    update();
  }
}