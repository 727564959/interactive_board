import 'dart:async';
import 'dart:convert';
import 'package:interactive_board/common.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/mirra_style.dart';

class MirraAppBar extends StatefulWidget {
  const MirraAppBar({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MirraAppBar> createState() => _MirraAppBarState();
}

class _MirraAppBarState extends State<MirraAppBar> {
  DateTime now = DateTime.now();
  late final Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(1.seconds, (timer) {
      setState(() {
        now = DateTime.now();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 50.w, right: 55.w, top: 50.w, bottom: 50.w),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: CustomTextStyles.title2(color: Colors.white, fontSize: 45.sp),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                DateFormat("Hm").format(now),
                style: CustomTextStyles.textSmall(color: Colors.white, fontSize: 27.sp),
              ),
              const SizedBox(width: 50),
              Text(
                "Bay ${ascii.decode([0x40 + Global.tableId])}",
                style: CustomTextStyles.title3(color: Colors.white, fontSize: 40.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
