import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'category_show_view.dart';
import 'question_view.dart';
import '../../logic.dart';

class QuizView extends StatefulWidget {
  const QuizView({super.key});

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  bool bQuestion = false;
  final logic = Get.find<QuizLogic>();
  @override
  void initState() {
    logic.soundEffect.questionTypePlay();
    Future.delayed(2.seconds).then((value) {
      logic.soundEffect.questionPlay();
      setState(() {
        bQuestion = true;
      });
    }).onError((error, stackTrace) async {
      print(error);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (bQuestion) {
      return const QuestionView();
    } else {
      return CategoryShowView();
    }
  }
}
