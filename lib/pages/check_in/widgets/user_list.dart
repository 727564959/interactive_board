import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interactive_board/pages/check_in/data/avatar_info.dart';
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
      final avatarInfo = logic.avatarInfo
          .firstWhere((element) => element.id == item.headgearId);
      final widget = GestureDetector(
        onTapUp: (detail) {
          logic.clickItem(item.id, item.nickname,
              avatarInfo.transparentBackgroundUrl, item.isMale);
          // logic.clickItem(item.id, item.nickname,
          //     logic.avatarInfo[i].transparentBackgroundUrl, item.isMale);
        },
        // child: GetBuilder<CheckInLogic>(
        //   id: "userListPage",
        //   builder: (logic) {
        //     return UserItem(
        //       width: width,
        //       nickname: item.nickname,
        //       userId: item.id,
        //     );
        //   },
        // ),
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
    return Container(
      width: width,
      height: height,
      child: Column(
        children: children(),
      ),
    );
  }
}
