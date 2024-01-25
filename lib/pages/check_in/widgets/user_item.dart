import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart' hide AnimationExtension;
import '../../../common.dart';
import '../logic.dart';

class UserItem extends StatefulWidget {
  UserItem({
    Key? key,
    required this.width,
    required this.nickname,
    required this.userId,
  }) : super(key: key);
  final double width;
  final String nickname;
  final String userId;
  final logic = Get.find<CheckInLogic>();

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> with TickerProviderStateMixin {
  double get width => widget.width;
  String get nickname => widget.nickname;
  String get userId => widget.userId;
  final logic = Get.find<CheckInLogic>();
  // late final AnimationController controller;

  @override
  void initState() {
    // controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  String get backgroundUrl {
    String path;
    if (userId == logic.userList[0].id && logic.selectedId == null) {
      path = "cell_bg_selected.png";
    } else {
      if (userId != logic.selectedId) {
        path = "cell_bg_default.png";
      } else {
        path = "cell_bg_selected.png";
      }
    }
    return Global.getCheckInImageUrl(path);
  }

  @override
  Widget build(BuildContext context) {
    // final height = width / 4;
    final height = width / 3;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (userId == logic.selectedId) {
        // controller.forward();
      } else {
        // controller.reverse();
      }
    });
    return Container(
      margin: EdgeInsets.symmetric(vertical: height / 10),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black26,
        // borderRadius: BorderRadius.circular(25.px)
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color: Colors.yellow,
          width: 0.5,
        ),
      ),
      child: Stack(
          children: [
            Row(
                children: [
                  SizedBox(
                    width: width,
                    child: Center(
                      child: Text(
                        nickname,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Burbank',
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontSize: width * 0.2,
                          letterSpacing: 3,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    // child: Text(
                    //   nickname,
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //     fontFamily: 'Burbank',
                    //     color: Colors.white,
                    //     decoration: TextDecoration.none,
                    //     fontSize: width * 0.2,
                    //     letterSpacing: 3,
                    //     fontWeight: FontWeight.normal,
                    //   ),
                    // ),
                  ),
                ],
            ),
          ],
      ),
    );
    // return Container(
    //   margin: EdgeInsets.symmetric(vertical: height / 10),
    //   width: width,
    //   height: height,
    //   child: Stack(
    //     children: [
    //       // Center(
    //       //   child: Image.asset(
    //       //     backgroundUrl,
    //       //     // width: userId != logic.selectedId ? width : width / 0.8,
    //       //     width:
    //       //         (userId == logic.userList[0].id && logic.selectedId == null)
    //       //             ? (width / 0.8)
    //       //             : (userId != logic.selectedId ? width : width / 0.8),
    //       //     height: height,
    //       //     fit: BoxFit.fill,
    //       //   ).animate(controller: controller, autoPlay: false).scale(
    //       //         begin: const Offset(1.0, 1.0),
    //       //         end: const Offset(1.05, 1.1),
    //       //         duration: 300.ms,
    //       //       ),
    //       // ),
    //       Row(
    //         children: [
    //           SizedBox(
    //             width: width,
    //             child: Text(
    //               nickname,
    //               textAlign: TextAlign.center,
    //               style: TextStyle(
    //                 fontFamily: 'Burbank',
    //                 color: Colors.white,
    //                 decoration: TextDecoration.none,
    //                 fontSize: width * 0.2,
    //                 fontWeight: FontWeight.normal,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}
