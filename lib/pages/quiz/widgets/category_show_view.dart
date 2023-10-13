import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'border_title.dart';
import '../logic.dart';

class CategoryShowView extends StatelessWidget {
  const CategoryShowView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BorderTitle(
            fontSize: 150.sp,
            title: "QUESTION 1",
          ),
        ],
      ),
    );
  }
}
