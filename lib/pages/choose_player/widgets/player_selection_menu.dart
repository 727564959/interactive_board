import 'dart:convert';

import 'package:flutter/material.dart';
import 'target_item.dart';

class PlayerSelectionMenu extends StatelessWidget {
  const PlayerSelectionMenu({Key? key, required this.width}) : super(key: key);
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(4, (index) => TargetItem(width: width * 0.16, deviceId: ascii.decode([0x41 + index]))),
      ),
    );
  }
}
