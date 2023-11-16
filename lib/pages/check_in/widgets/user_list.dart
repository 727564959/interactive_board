import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../logic.dart';
import 'user_item.dart';

class UserList extends StatelessWidget {
  UserList({Key? key, required this.width, required this.height})
      : super(key: key);
  final double width;
  final double height;
  final logic = Get.find<CheckInLogic>();
  List<Widget> children() {
    final result = <Widget>[];
    for (int i = 0; i < logic.userList.length; i++) {
      final item = logic.userList[i];
      final widget = GestureDetector(
        onTapUp: (detail) {
          logic.clickItem(item.id, item.nickname);
        },
        child: UserItem(
          width: width,
          nickname: item.nickname,
          userId: item.id,
        ),
      );
      result.add(widget);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    // return Stack(
    //   alignment: AlignmentDirectional.center,
    //   children: [
    //     Align(
    //       alignment: const Alignment(0.1, -0.6),
    //       child: Container(
    //         width: width,
    //         height: height,
    //         child: Column(
    //           children: children(),
    //         ),
    //       ),
    //     ),
    //   ],
    // );

    return Container(
      width: width,
      height: height,
      child: Column(
        children: children(),
      ),
    );
  }
}
