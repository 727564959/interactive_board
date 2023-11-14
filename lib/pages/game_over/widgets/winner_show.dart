import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:interactive_board/common.dart';

class WinnerShow extends StatefulWidget {
  const WinnerShow({Key? key, required this.winner}) : super(key: key);
  final int winner;
  @override
  State<WinnerShow> createState() => _WinnerShowState();
}

class _WinnerShowState extends State<WinnerShow> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 180.h),
        Text(
          "The winner is",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 80.sp,
            decoration: TextDecoration.none,
            fontFamily: 'Burbank',
            color: Colors.white,
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          "Team ${widget.winner == 0 ? "Wolf" : "Shark"}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 230.sp,
            decoration: TextDecoration.none,
            fontFamily: 'Burbank',
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
