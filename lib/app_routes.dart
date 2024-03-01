import 'package:get/get.dart';
import 'pages/check_in/binding.dart';
import 'pages/check_in/welcome_page.dart';
import 'pages/check_in/view.dart';
import 'modules/before_game/choose_player/view.dart';
import 'pages/game_over/binding.dart';
import 'modules/initialize_page/view.dart';
import 'modules/initialize_page/binding.dart';
import 'modules/before_game/choose_player/binding.dart';
import 'modules/gaming/gaming_rank/view.dart';
import 'modules/gaming/gaming_rank/binding.dart';
import 'modules/quiz/view.dart';
import 'modules/quiz/binding.dart';
import 'pages/game_over/view.dart';

class AppRoutes {
  static const String main = "/home";
  static const String choosePlayer = "/choose_player";
  static const String gamingRank = "/gaming_rank";
  static const String quiz = "/quiz";
  // 游戏结算
  static const String gameOver = "/game_over";
  static const String checkIn = "/check_in";

  static final List<GetPage> getPages = [
    GetPage(
      name: main,
      page: () => InitializePage(),
      binding: InitializeBinding(),
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
      name: checkIn,
      // page: () => CheckInPage(),
      page: () => WelcomePage(),
      bindings: [CheckInBinding()],
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
  ];
}
