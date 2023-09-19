import 'package:get/get.dart';
import 'pages/choose_player/view.dart';
import 'pages/home/view.dart';
import 'pages/choose_player/binding.dart';

class AppRoutes {
  static const String main = "/home";
  static const String choosePlayer = "/home/choose_player";
  static final List<GetPage> getPages = [
    GetPage(
      name: main,
      page: () => HomePage(),
    ),
    GetPage(
      name: choosePlayer,
      page: () => ChoosePlayerPage(),
      bindings: [ChoosePlayerBinding()],
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
  ];
}
