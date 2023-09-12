import 'dart:ui';
import 'package:flutter/material.dart';

class Global {
  static int tableId = 1;
  static get team => tableId < 5 ? 0 : 1;
  static String getAssetImageUrl(String filename) {
    return team == 0 ? "assets/images/team_wolf/$filename" : "assets/images/team_shark/$filename";
  }

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
