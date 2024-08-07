import 'dart:math';

import 'package:get/get.dart';

import '../../app_routes.dart';
import 'sound_effect.dart';
import 'data/question.dart';
import 'data/quiz_repository.dart';
import 'data/settlement.dart';

enum PageState { loading, waiting, question, complete }

class QuizState {
  QuizState(this.question);
  final QuestionInfo question;
  int? selected;
  bool bShowAnswer = false; //是否展示答案
}

class QuizLogic extends GetxController {
  late final int quizRoundStartTimestamp;
  late final int questionCount;
  int get countdown => max(0, (quizRoundStartTimestamp - DateTime.now().millisecondsSinceEpoch) ~/ 1000);
  QuizState? quizState;
  List<SettlementInfo> records = [];
  final soundEffect = SoundEffect();

  PageState pageState = PageState.loading;
  late final QuizRepository quizRepository;
  int score = 0;

  void select(int idx) async {
    if (quizState!.selected != null || quizState!.bShowAnswer) return;
    await quizRepository.select(idx);
    quizState!.selected = idx;
    soundEffect.clickPlay();
    update(['answer']);
  }

  @override
  void onInit() async {
    super.onInit();
    quizRoundStartTimestamp = Get.arguments["waitingSeconds"] * 1000 + DateTime.now().millisecondsSinceEpoch;
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
          soundEffect.rightPlay();
        } else {
          soundEffect.wrongPlay();
        }
        update(['answer', 'score']);
      },
      onComplete: (List<SettlementInfo> records) {
        pageState = PageState.complete;
        this.records = records;
        update(['page']);
        Future.delayed(20.seconds).then((value) {
          if (Get.currentRoute == AppRoutes.quiz) {
            Get.back();
          }
        });
      },
      onClose: () {
        if (Get.currentRoute == AppRoutes.quiz) {
          Get.back();
        }
      },
    );
    await quizRepository.join();
    pageState = PageState.waiting;
    update(['page']);
  }

  @override
  void onClose() {
    soundEffect.dispose();
    quizRepository.dispose();
    super.onClose();
  }
}
