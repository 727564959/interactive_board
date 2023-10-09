import 'dart:ui';
import 'package:flutter/material.dart';

class Global {
  static int tableId = 4;
  static get team => tableId < 5 ? 0 : 1;
  static String getAssetImageUrl(String filename) {
    return team == 0 ? "assets/images/team_wolf/$filename" : "assets/images/team_shark/$filename";
  }

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
