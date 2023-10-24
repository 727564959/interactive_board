import 'package:get/get.dart';
import 'package:interactive_board/pages/quiz/logic.dart';
import 'pages/choose_player/view.dart';
import 'pages/game_over/binding.dart';
import 'pages/game_statistics/binding.dart';
import 'pages/home/view.dart';
import 'pages/choose_player/binding.dart';
import 'pages/gaming_rank/view.dart';
import 'pages/gaming_rank/binding.dart';
import 'pages/quiz/view.dart';
import 'pages/quiz/binding.dart';

import 'pages/game_over/view.dart';
import 'pages/game_statistics/bar_chart_page.dart';
import 'pages/game_glory/view.dart';
import 'pages/game_next/view.dart';

class AppRoutes {
  static const String main = "/";
  static const String choosePlayer = "/choose_player";
  static const String gamingRank = "/gaming_rank";
  static const String quiz = "/quiz";
  // 游戏获胜队伍
  static const String gameOver = "/home/game_over";
  // 游戏排名统计
  static const String gameStatistics = "/home/game_statistics";
  // 本队荣誉展示
  static const String gameGlory = "/home/game_glory";
  // 下一个游戏
  static const String gameNext = "/home/game_next";

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
    GetPage(
      name: gameStatistics,
      page: () => BarChartPage(),
      bindings: [GameStatisticsBinding()],
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
    GetPage(
      name: gameGlory,
      page: () => GameGloryPage(),
      // bindings: [GameGloryBinding()],
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
    GetPage(
      name: gameNext,
      page: () => GameNextPage(),
      // bindings: [GameNextBinding()],
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
  ];
}
