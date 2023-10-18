import 'package:get/get.dart';
import 'package:interactive_board/pages/quiz/logic.dart';
import 'pages/choose_player/view.dart';
import 'pages/home/view.dart';
import 'pages/choose_player/binding.dart';
import 'pages/gaming_rank/view.dart';
import 'pages/gaming_rank/binding.dart';
import 'pages/quiz/view.dart';
import 'pages/quiz/binding.dart';

class AppRoutes {
  static const String main = "/";
  static const String choosePlayer = "/choose_player";
  static const String gamingRank = "/gaming_rank";
  static const String quiz = "/quiz";
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
  ];
}
