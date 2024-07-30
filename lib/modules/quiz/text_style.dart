import 'package:flutter/material.dart';

class TriviaTextStyles {
  static TextStyle title({
    Color? color,
    double? fontSize,
  }) {
    return TextStyle(
      fontSize: fontSize,
      decoration: TextDecoration.none,
      fontFamily: 'Anton',
      color: color,
    );
  }

  static TextStyle content({
    Color? color,
    double? fontSize,
  }) {
    const fontVariations = [
      FontVariation("GRAD", 0),
      FontVariation.weight(500),
      FontVariation.slant(0),
      FontVariation("XOPQ", 96),
      FontVariation("YOPQ", 84),
      FontVariation("XTRA", 468),
      FontVariation("YTUC", 528),
      FontVariation("YTLC", 520),
      FontVariation("YTAS", 649),
      FontVariation("YTDE", -181),
      FontVariation("YTFI", 560),
      FontVariation.width(151),
    ];
    return TextStyle(
      fontSize: fontSize,
      decoration: TextDecoration.none,
      fontFamily: 'RobotoFlex',
      color: color,
      fontVariations: fontVariations,
    );
  }
}
