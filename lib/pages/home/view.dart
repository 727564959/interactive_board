import 'package:flutter/material.dart';
import '../../common.dart';
import '../../app_routes.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.quiz);
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Global.getAssetImageUrl("background.png")),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}