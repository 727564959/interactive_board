import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// const String baseApiUrl = 'http://10.1.4.13:1337/api';
// const String baseSocketIoUrl = 'http://10.1.4.13:12333';
// const String baseStrapiUrl = 'http://10.1.4.13:1337';

const String baseResovaUrl = "http://52.88.128.42:25146";
// const String baseApiUrl = 'http://10.1.4.16:1337/api';
// const String baseSocketIoUrl = 'http://10.1.4.16:12333';
// const String baseStrapiUrl = 'http://10.1.4.16:1337';

const String baseApiUrl = 'http://www.mir2021.xyz:1337/api';
const String baseSocketIoUrl = 'http://www.mir2021.xyz:12333';
const String baseStrapiUrl = 'http://www.mir2021.xyz:1337';
// const String baseResovaUrl = "http://www.mir2021.xyz:25146";

final routeObserver = RouteObserver<ModalRoute<void>>();

class Global {
  static int? _tableId;
  static bool get bTableIdExist => _tableId != null;
  static int get tableId => _tableId!;
  static void setTableId(int tableId) {
    _tableId = tableId;
    SharedPreferences.getInstance().then((prefs) => prefs.setInt('tableId', tableId));
  }

  static get team => (_tableId ?? 0) < 3 ? 0 : 1;
  static String getAssetImageUrl(String filename) {
    return team == 0 ? "assets/images/team_wolf/$filename" : "assets/images/team_shark/$filename";
  }

  static String getDeviceName(int position) {
    final char = ascii.decode([0x40 + (position + 1) ~/ 2]);
    return "Device $char${(position + 1) % 2 + 1}";
  }

  static OverlayEntry? _entry;

  static String getQuizIconUrl(String filename) => "assets/images/quiz/$filename";
  static String getGifUrl(String filename) => "assets/images/gif/$filename";
  // checkin的图片资源
  static String getCheckInImageUrl(String filename) => "assets/images/check_in/$filename";
  // checkin的图片资源
  static String getSetAvatarImageUrl(String filename) => "assets/images/set_avatar/$filename";

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
