import 'package:flutter/material.dart';

const buttonFontVariations = [
  FontVariation.width(140),
  FontVariation.opticalSize(100),
  FontVariation.weight(800),
  FontVariation("GRAD", 80),
  FontVariation("XOPQ", 96),
  FontVariation("YOPQ", 79),
  FontVariation("XTRA", 468),
  FontVariation("YTUC", 712),
  FontVariation("YTLC", 514),
  FontVariation("YTDE", -203),
  FontVariation("YTFI", 738),
  FontVariation("YTAS", 750),
];

class CustomTextStyles {
  static TextStyle button({
    Color? color,
    double? fontSize,
  }) {
    return TextStyle(
      fontSize: fontSize,
      decoration: TextDecoration.none,
      fontFamily: 'RobotoFlex',
      color: color,
      fontVariations: buttonFontVariations,
    );
  }

  static TextStyle textSmall({
    Color? color,
    double? fontSize,
  }) {
    return TextStyle(
      // fontWeight: FontWeight.normal,
      fontSize: fontSize,
      decoration: TextDecoration.none,
      fontFamily: 'RobotoFlex',
      color: color,
      fontVariations: [
        FontVariation.width(140),
        FontVariation.opticalSize(100),
        FontVariation.weight(800),
        FontVariation("GRAD", 80),
        FontVariation("XOPQ", 96),
        FontVariation("YOPQ", 79),
        FontVariation("XTRA", 468),
        FontVariation("YTUC", 712),
        FontVariation("YTLC", 514),
        FontVariation("YTDE", -203),
        FontVariation("YTFI", 738),
        FontVariation("YTAS", 750),
      ],
    );
  }
}

class Icons {
  static String getQuizIconPath(String filename) => "assets/images/quiz/$filename";
  static String getCheckInIconPath(String filename) => "assets/images/check_in/$filename";
  static String getSetAvatarIconPath(String filename) => "assets/images/set_avatar/$filename";
}
