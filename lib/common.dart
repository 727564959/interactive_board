import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static int? _tableId;
  static bool get bTableIdExist => _tableId != null;
  static int get tableId => _tableId!;
  static void setTableId(int tableId) {
    _tableId = tableId;
    SharedPreferences.getInstance()
        .then((prefs) => prefs.setInt('tableId', tableId));
  }

  static get team => (_tableId ?? 0) < 5 ? 0 : 1;
  static String getAssetImageUrl(String filename) {
    return team == 0
        ? "assets/images/team_wolf/$filename"
        : "assets/images/team_shark/$filename";
  }

  static OverlayEntry? _entry;

  static String getQuizIconUrl(String filename) =>
      "assets/images/quiz/$filename";
  static String getGifUrl(String filename) => "assets/images/gif/$filename";
  // checkin的图片资源
  static String getCheckInImageUrl(String filename) =>
      "assets/images/check_in/$filename";

  static const String baseApiUrl = 'http://10.1.4.13:1337/api';
  static TextStyle getNormalTextStyle(double fontSize) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: fontSize,
      decoration: TextDecoration.none,
      fontFamily: 'Burbank',
      color: Colors.white,
    );
  }
}
