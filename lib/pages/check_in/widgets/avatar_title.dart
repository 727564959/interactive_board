import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/pages/check_in/logic.dart';

import '../../../../common.dart';
import 'dart:async';

class AvatarTitlePage extends StatelessWidget {
  AvatarTitlePage({
    Key? key,
    required this.titleText,
  }) : super(key: key);
  final String titleText;

  final logic = Get.find<CheckInLogic>();

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   color: Colors.red,
      //   borderRadius: BorderRadius.all(Radius.circular(10)),
      // ),
      margin: EdgeInsets.only(top: 40.0, left: 0.0),
      constraints: BoxConstraints.tightFor(width: 1.0.sw, height: 100.sp),//卡片大小
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(top: 0.0, left: 60.0),
            child: Text(
              titleText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 60.sp,
                decoration: TextDecoration.none,
                fontFamily: 'BurbankBold',
                color: Colors.white,
                letterSpacing: 3.sp,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 0.0, right: 60.0),
            constraints: BoxConstraints.tightFor(width: 0.1.sw),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CurrentTimer(),
                Text(
                  "Table " + Global.tableId.toString(),
                  style: TextStyle(
                    fontSize: 32.sp,
                    decoration: TextDecoration.none,
                    fontFamily: 'BurbankBold',
                    color: Colors.deepOrange,
                    letterSpacing: 3.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CurrentTimer extends StatefulWidget {
  const CurrentTimer({Key? key});

  @override
  _CurrentTimerState createState() => _CurrentTimerState();
}
class _CurrentTimerState extends State<CurrentTimer> {
  //时间日期开始
  late Timer _timer;
  late DateTime dateTime;

  @override
  void initState() {
    super.initState();
    dateTime = new DateTime.now();
    this._timer = new Timer.periodic(Duration (seconds: 1), setTime);
  }
  void setTime(Timer timer) {
    setState(() {
      dateTime = new DateTime.now();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "${dateTime.hour}:${dateTime.minute.toString().padLeft(2,'0')}",
      style: TextStyle(
        fontSize: 32.sp,
        decoration: TextDecoration.none,
        fontFamily: 'BurbankBold',
        color: Colors.white,
        letterSpacing: 3.sp,
      ),
    );
    // return Scaffold(
    //   body: new Container(
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         // Padding(
    //         //     padding: EdgeInsets.only(top: 200)
    //         // ),
    //         Text(
    //           "${dateTime.hour}:${dateTime.minute.toString().padLeft(2,'0')}",
    //           style: TextStyle(
    //             fontSize: 32.sp,
    //             decoration: TextDecoration.none,
    //             fontFamily: 'BurbankBold',
    //             color: Colors.white,
    //             letterSpacing: 3.sp,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}