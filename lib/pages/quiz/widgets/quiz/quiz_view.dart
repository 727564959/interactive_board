import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'category_show_view.dart';
import 'question_view.dart';

class QuizView extends StatefulWidget {
  const QuizView({Key? key}) : super(key: key);

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  bool bQuestion = false;
  @override
  void initState() {
    Future.delayed(2.seconds).then((value) => setState(() {
          bQuestion = true;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (bQuestion) {
      return QuestionView();
    } else {
      return CategoryShowView();
    }
    return const Placeholder();
  }
}
