import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(1920, 1080),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp(
            key: navigatorKey,
            theme: ThemeData(
              splashFactory: NoSplash.splashFactory,
              scaffoldBackgroundColor: const Color(0xFF212332),
              textTheme: const TextTheme(
                bodyMedium: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 40,
                  decoration: TextDecoration.none,
                  fontFamily: 'Burbank',
                  color: Colors.white,
                ),
              ),
              canvasColor: const Color(0xFF2A2D3E),
              highlightColor: Colors.transparent,
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.main,
            getPages: AppRoutes.getPages,
          );
        });
  }
}
