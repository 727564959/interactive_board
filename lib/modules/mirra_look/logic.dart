import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
  final nameTextFieldController = TextEditingController();

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

  // 敏感字判断
  Future<Map> sensitiveWordDetector(text) async {
    print("敏感字判断");
    print(text);
    final response = await _dio.get(
        "https://inb27b1nma.execute-api.us-east-1.amazonaws.com/bad-words-checked",
        queryParameters: {"text": text}
    );
    print(response.data);
    Map<String, dynamic> result = json.decode(response.data);
    return result;
  }

  @override
  void onInit() async {
    super.onInit();
    update();
  }
}