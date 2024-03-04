import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/pages/check_in/logic.dart';

import '../../../../common.dart';
import '../before_checkIn/term_of_use.dart';

class PlayerInfoShow extends StatelessWidget {
  PlayerInfoShow({Key? key}) : super(key: key);
  final logic = Get.find<CheckInLogic>();

  final String dateTime = DateTime.now().toString().substring(11, 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              width: 1.0.sw,
              height: 1.0.sh,
              color: Colors.black,
              child: Column(
                children: [
                  SizedBox(
                    width: 0.94.sw,
                    height: 100.h,
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Align(
                              alignment: const Alignment(0.5, 1.5),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 0.1.sw,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: 0.05.sw,
                                          child: Text(
                                            dateTime,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 32.sp,
                                              decoration: TextDecoration.none,
                                              fontFamily: 'BurbankBold',
                                              color: Colors.white,
                                              letterSpacing: 3.sp,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 0.05.sw,
                                          child: Text(
                                            " Table 1",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 28.sp,
                                              decoration: TextDecoration.none,
                                              fontFamily: 'BurbankBold',
                                              color: Colors.deepOrange,
                                              letterSpacing: 3.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: GetBuilder<CheckInLogic>(
                      builder: (logic) {
                        return Column(
                            children: [
                              Align(
                                heightFactor: 2,
                                alignment: const Alignment(-0.8, 1.0),
                                child: Text(
                                  "Hi, there!",
                                  style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 120.sp,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'BurbankBold',
                                    color: Colors.white,
                                    letterSpacing: 3.sp,
                                  ),
                                ),
                              ),
                              Align(
                                heightFactor: 1,
                                alignment: const Alignment(-0.8, 0.0),
                                child: Text(
                                  "Set your avatar",
                                  style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 120.sp,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'BurbankBold',
                                    color: Colors.white,
                                    letterSpacing: 3.sp,
                                  ),
                                ),
                              ),
                            ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    child: GetBuilder<CheckInLogic>(
                      builder: (logic) {
                        return Column(
                          children: [
                            // Row(
                            //   children: [
                            //     _NicknameArea(),
                            //   ],
                            // ),
                            _NicknameArea(),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 20.0, left: 80.0),
                                  child: _AddPlayerButton(width: 306.w),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            GetBuilder<CheckInLogic>(builder: (logic) {
              return Container();
            }),
          ],
        ));
  }
}
// 玩家姓名
class _NicknameArea extends StatelessWidget {
  _NicknameArea({
    Key? key,
  }) : super(key: key);
  final logic = Get.find<CheckInLogic>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        print("修改名字");
        // logic.isUpdateNameFun(true);
      },
      child: GetBuilder<CheckInLogic>(
        id: "nicknameArea",
        builder: (logic) {
          return Container(
            // decoration: BoxDecoration(
            //   color: Colors.deepOrangeAccent,
            // ),
            margin: EdgeInsets.only(top: 80.0, left: 80.0),
            // constraints: BoxConstraints.tightFor(width: 428.w, height: 118.h),//卡片大小
            child: Wrap(
              // 子项间距
              spacing: 10,
              // 行间距
              runSpacing: 20,
              children: List.generate(logic.userList.length, (index) => getItem(index)),
            ),
            // child: Container(
            //   margin: EdgeInsets.only(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0),
            //   child: Text(
            //     logic.userList[0].nickname,
            //     style: TextStyle(
            //       fontSize: 60.sp,
            //       decoration: TextDecoration.none,
            //       fontFamily: 'BurbankBold',
            //       color: Colors.black,
            //       letterSpacing: 3.sp,
            //     ),
            //   ),
            // ),
          );
        },
      ),
    );
  }
}
/// 获取子项目
Widget getItem(int index) {
  final logic = Get.find<CheckInLogic>();
  var item = logic.userList[index % logic.userList.length];
  return Chip(
    // 文字标签
    label: Text(item.nickname,
          style: TextStyle(
            fontSize: 60.sp,
            decoration: TextDecoration.none,
            fontFamily: 'BurbankBold',
            color: Colors.black,
            letterSpacing: 3.sp,
          ),),
    // 删除按钮，添加后回自动设置 Icon
    onDeleted: () {},
  );
}
// 添加用户按钮
class _AddPlayerButton extends StatelessWidget {
  _AddPlayerButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  final logic = Get.find<CheckInLogic>();
  String get backgroundUri => Global.getSetAvatarImageUrl("add_btn.png");

  final testTabId = Global.tableId;
  // final testTabId = 3;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () {
        print("添加用户");
        Get.to(() => TermOfUsePage(), arguments: Get.arguments);
      },
      child: GetBuilder<CheckInLogic>(
        id: "addPlayerBtn",
        builder: (logic) {
          return Container(
            height: width * 0.3,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundUri),
                fit: BoxFit.fitWidth,
              ),
            ),
          );
        },
      ),
    );
  }
}