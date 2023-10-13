import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common.dart';

import 'widgets/cover_view.dart';
import 'widgets/tips_view.dart';
import 'widgets/question_view.dart';
import 'widgets/category_show_view.dart';

class QuizCoverPage extends StatelessWidget {
  const QuizCoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1.0.sw,
        height: 1.0.sh,
        color: Colors.black,
        child: const CategoryShowView(),
      ),
    );
  }
}
