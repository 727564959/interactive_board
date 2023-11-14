import 'package:get/get.dart';
import 'pages/choose_player/view.dart';
import 'pages/game_over/binding.dart';
import 'pages/home/view.dart';
import 'pages/choose_player/binding.dart';
import 'pages/gaming_rank/view.dart';
import 'pages/gaming_rank/binding.dart';
import 'pages/quiz/view.dart';
import 'pages/quiz/binding.dart';

import 'pages/game_over/view.dart';

class AppRoutes {
  static const String main = "/home";
  static const String choosePlayer = "/choose_player";
  static const String gamingRank = "/gaming_rank";
  static const String quiz = "/quiz";
  // 游戏结算
  static const String gameOver = "/game_over";

  static final List<GetPage> getPages = [
    GetPage(
      name: main,
      page: () => const HomePage(),
    ),
    GetPage(
      name: choosePlayer,
      page: () => ChoosePlayerPage(),
      bindings: [ChoosePlayerBinding()],
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
    GetPage(
      name: gamingRank,
      page: () => GamingRankPage(),
      bindings: [GamingRankBinding()],
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
    GetPage(
      name: quiz,
      page: () => QuizCoverPage(),
      bindings: [QuizBinding()],
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
    GetPage(
      name: gameOver,
      page: () => GameOverPage(),
      bindings: [GameOverBinding()],
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
  ];
}
