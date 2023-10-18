import 'dart:math';

import 'package:get/get.dart';
import 'data/question.dart';
import 'data/quiz_repository.dart';

enum PageState { waiting, question }

class QuizState {
  QuizState(this.question);
  final QuestionInfo question;
  int? selected;
  bool bShowAnswer = false;
}

class QuizLogic extends GetxController {
  late final int startTimestamp;
  late final int questionCount;
  int get countdown => max(0, (startTimestamp - DateTime.now().millisecondsSinceEpoch) ~/ 1000);
  bool joinedQuiz = false;
  QuizState? quizState;
  PageState pageState = PageState.waiting;
  late final QuizRepository quizRepository;
  int score = 0;

  void join() async {
    if (joinedQuiz) return;
    await quizRepository.join();
    joinedQuiz = true;
    update(["joined"]);
  }

  void select(int idx) async {
    if (quizState!.selected != null) return;
    await quizRepository.select(idx);
    quizState!.selected = idx;
    update(['answer']);
  }

  @override
  void onInit() async {
    super.onInit();
    startTimestamp = Get.arguments["startTimestamp"];
    questionCount = Get.arguments["questionCount"];
    quizRepository = QuizRepository(
      onQuestionRound: (question) {
        pageState = PageState.question;
        quizState = QuizState(question);
        update(['page']);
      },
      onAnswerShow: () {
        final state = quizState!;
        state.bShowAnswer = true;
        if (state.selected == state.question.correctAnswer) {
          score += 10;
        }
        update(['answer', 'score']);
      },
      onClose: () {
        Get.back();
      },
    );
  }

  @override
  void onClose() {
    print("onClose");
    quizRepository.dispose();
    super.onClose();
  }
}
