import 'dart:math';

import 'package:get/get.dart';

import '../../app_routes.dart';
import 'sound_effect.dart';
import 'data/question.dart';
import 'data/quiz_repository.dart';
import 'data/settlement.dart';

enum PageState { loading, category, waiting, question, complete }

class QuizState {
  QuizState(this.question);
  final QuestionInfo question;
  int? selected;
  bool bShowAnswer = false; //是否展示答案
  int score = 0;
}

class TriviaConfig {
  final int logoTime;
  final int categoryTime;
  final int questionTime;
  final int answerTime;
  final int questionCount;
  final int triviaBeginTimestamp;
  TriviaConfig(
    this.logoTime,
    this.categoryTime,
    this.questionTime,
    this.answerTime,
    this.questionCount,
    this.triviaBeginTimestamp,
  );
  factory TriviaConfig.fromJson(dynamic data) {
    return TriviaConfig(
      data['logoTime'],
      data["categoryTime"],
      data["questionTime"],
      data["answerTime"],
      data["questionCount"],
      data["triviaBeginTimestamp"],
    );
  }
}

class QuizLogic extends GetxController {
  late final int quizRoundStartTimestamp;
  late TriviaConfig config;
  int get countdown => max(0, (quizRoundStartTimestamp - DateTime.now().millisecondsSinceEpoch) ~/ 1000);
  QuizState? quizState;
  List<SettlementInfo> records = [];
  final soundEffect = SoundEffect();

  PageState pageState = PageState.loading;
  late final QuizRepository quizRepository;
  int score = 0;

  void select(int idx) async {
    if (quizState!.selected != null || quizState!.bShowAnswer) return;
    quizState!.selected = idx;
    soundEffect.clickPlay();
    update(['answer']);
    quizState!.score = await quizRepository.select(idx);
  }

  @override
  void onInit() async {
    super.onInit();
    config = TriviaConfig.fromJson(Get.arguments);
    quizRoundStartTimestamp = (config.logoTime * 1000).toInt() + DateTime.now().millisecondsSinceEpoch;
    quizRepository = QuizRepository(
      onCategoryShow: (round, category) {
        pageState = PageState.category;
        quizState = QuizState(QuestionInfo(
          round: round,
          category: category,
          title: "",
          choices: [],
          answer: 0,
        ));
        update(['page']);
      },
      onQuestionRound: (question) {
        pageState = PageState.question;
        quizState = QuizState(question);
        update(['page']);
      },
      onAnswerShow: () {
        final state = quizState!;
        state.bShowAnswer = true;
        if (state.selected == state.question.answer) {
          score += state.score;
          soundEffect.rightPlay();
        } else {
          soundEffect.wrongPlay();
        }
        update(['answer', 'score']);
      },
      onSettlement: (List<SettlementInfo> records) {
        pageState = PageState.complete;
        this.records = records;
        update(['page']);
      },
      onClose: () {
        if (Get.currentRoute == AppRoutes.quiz) {
          Get.back();
        }
      },
    );
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
