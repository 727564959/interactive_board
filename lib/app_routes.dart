import 'package:get/get.dart';
import 'package:interactive_board/modules/game_over/honor/binding.dart';
import 'modules/check_in/choose_table/view.dart';
import 'modules/check_in/complete_page/view.dart';
import 'modules/game_over/honor/view.dart';
import 'modules/game_over/winner/binding.dart';
import 'modules/game_over/winner/view.dart';
import 'modules/set_avatar/binding.dart';
import 'modules/set_avatar/view.dart';
import 'modules/take_a_rest/view.dart';
import 'pages/check_in/binding.dart';
import 'pages/check_in/view.dart';
import 'pages/check_in/welcome_page.dart';
// import 'pages/check_in/view.dart';
import 'modules/before_game/choose_player/view.dart';
import 'modules/initialize_page/view.dart';
import 'modules/initialize_page/binding.dart';
import 'modules/before_game/choose_player/binding.dart';
import 'modules/gaming/gaming_rank/view.dart';
import 'modules/gaming/gaming_rank/binding.dart';
import 'modules/quiz/view.dart';
import 'modules/quiz/binding.dart';
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
  // 桌屏等待页面
  static const String takeARest = "/take_a_rest";
  static const String setAvatar = "/setAvatar";
  // 获胜这页面
  static const String winnerPage = "/winnerPage";
  // 荣誉墙展示
  static const String honorPage = "/honorPage";

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
      name: checkIn,
      page: () => CheckInPage(),
      // page: () => WelcomePage(),
      bindings: [CheckInBinding()],
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
      name: setAvatar,
      page: () => AvatarDesignPage(),
      bindings: [SetAvatarBinding()],
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
      name: honorPage,
      page: () => HonorPage(),
      bindings: [HonorBinding()],
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
  ];
}
