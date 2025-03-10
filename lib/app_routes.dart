import 'package:get/get.dart';
import 'package:interactive_board/modules/before_game/confirm_selection/view.dart';
import 'package:interactive_board/modules/game_over/honor/binding.dart';
import 'modules/check_in/home_page/landing_page.dart';
import 'modules/check_in/home_page/view.dart';
import 'modules/game_over/game_playing/free_game_playing.dart';
import 'modules/game_over/game_playing/view.dart';
import 'modules/game_over/honor/view.dart';
import 'modules/game_over/show_end/view.dart';
import 'modules/game_over/statistics/binding.dart';
import 'modules/game_over/statistics/view.dart';
import 'modules/game_over/winner/binding.dart';
import 'modules/game_over/winner/view.dart';
import 'modules/table_check/welcome_page/welcome_page.dart';
import 'modules/take_a_rest/view.dart';
import 'modules/before_game/choose_player/view.dart';
import 'modules/initialize_page/view.dart';
import 'modules/initialize_page/binding.dart';
import 'modules/before_game/choose_player/binding.dart';
import 'modules/gaming/gaming_rank/view.dart';
import 'modules/gaming/gaming_rank/binding.dart';
import 'modules/check_in/verification_code/view.dart';

class AppRoutes {
  static const String main = "/home";
  static const String choosePlayer = "/choose_player";
  static const String gamingRank = "/gaming_rank";
  static const String quiz = "/quiz";
  // 游戏结算
  static const String gameOver = "/game_over";
  static const String checkIn = "/check_in";
  static const String verificationCode = "/verification_code";
  static const String landingPage = "/landingPage";
  static const String gamePlayingPage = "/gamePlayingPage";
  static const String freeGamePlayingPage = "/freeGamePlayingPage";
  static const String showEndPage = "/showEndPage";
  // 桌屏等待页面
  static const String takeARest = "/take_a_rest";
  // 获胜这页面
  static const String winnerPage = "/winnerPage";
  // 统计图展示
  static const String statisticsPage = "/statisticsPage";
  // 荣誉墙展示
  static const String honorPage = "/honorPage";
  static const String confirmChoicePlayerPage = "/confirmChoicePlayerPage";

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
      name: confirmChoicePlayerPage,
      page: () => const ConfirmSelectionPage(),
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
      name: checkIn,
      // page: () => CheckInPage(),
      page: () => WelcomePlayerPage(),
      // page: () => WelcomePage(),
      // bindings: [CheckInBinding()],
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
    GetPage(
      name: landingPage,
      // page: () => LandingPage(),
      page: () => LandingCheckIn(),
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
    GetPage(
      name: gamePlayingPage,
      page: () => GamePlayingPage(),
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
    GetPage(
      name: freeGamePlayingPage,
      page: () => FreeGamePlayingPage(),
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
    GetPage(
      name: showEndPage,
      page: () => GameShowEndPage(),
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
    GetPage(
      name: verificationCode,
      page: () => VerificationPage(),
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
    GetPage(
      name: takeARest,
      page: () => TakeARestPage(),
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),

    GetPage(
      name: winnerPage,
      page: () => WinnerPage(),
      bindings: [WinnerBinding()],
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
    GetPage(
      name: statisticsPage,
      page: () => StatisticsPage(),
      bindings: [StatisticsBinding()],
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
    GetPage(
      name: honorPage,
      page: () => HonorPage(),
      bindings: [HonorBinding()],
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
    // GetPage(
    //   name: nextGame,
    //   page: () => NextGamePage(),
    //   transitionDuration: Duration.zero,
    //   reverseTransitionDuration: Duration.zero,
    // ),
  ];
}
