import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'target_item.dart';
import '../logic.dart';

class PlayerSelectionMenu extends StatelessWidget {
  PlayerSelectionMenu({Key? key, required this.width}) : super(key: key);
  final double width;
  final logic = Get.find<ChoosePlayerLogic>();
  double get itemWidth => width * 0.16;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          4,
          (index) => TargetItem(
            width: itemWidth,
            deviceId: ascii.decode([0x41 + index]),
            index: index,
          ),
        ),
      ),
    );
  }
}
