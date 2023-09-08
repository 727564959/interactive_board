import 'package:get/get.dart';
import 'pages/choose_player/view.dart';

class AppRoutes {
  static const String main = "/";
  static final List<GetPage> getPages = [
    GetPage(
      name: main,
      page: () => const ChoosePlayerPage(),
    ),
  ];
}
