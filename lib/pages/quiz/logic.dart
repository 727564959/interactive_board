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
  bool bShowAnswer = false;
}

class QuizLogic extends GetxController {
  late final int startTimestamp;
  late final int questionCount;
  int get countdown => max(0, (startTimestamp - DateTime.now().millisecondsSinceEpoch) ~/ 1000);
  bool joinedQuiz = false;
  QuizState? quizState;
  List<SettlementInfo> records = [];
  final soundEffect = SoundEffect();

  PageState pageState = PageState.loading;
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
    soundEffect.clickPlay();
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
            Get.offAllNamed(AppRoutes.main);
          }
        });
      },
      onClose: () {
        if (Get.currentRoute == AppRoutes.quiz) {
          Get.offAllNamed(AppRoutes.main);
        }
      },
    );
    await soundEffect.load();
    pageState = PageState.waiting;
    update(['page']);
  }

  @override
  void onClose() {
    print("onClose");
    soundEffect.dispose();
    quizRepository.dispose();
    super.onClose();
  }
}
