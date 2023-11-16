import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common.dart';
import '../../data/network/process_controller.dart';
import '../../data/network/show_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final showRepository = GameShowRepository();
  int? tableId;
  void update() {
    SharedPreferences.getInstance().then((pref) {
      tableId = pref.getInt('tableId');
      if (tableId != null) {
        Global.setTableId(tableId!);
        setState(() {});
      }
      showRepository.updateShowState().then((value) {
        if (showRepository.showId != null && tableId != null) {
          Get.offNamed(AppRoutes.choosePlayer);
        }
      });
    });
  }

  @override
  void initState() {
    ProcessController();
    super.initState();
    update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onLongPress: () {
          Get.dialog(
            Center(
              child: Container(
                width: 600.w,
                height: 800.w,
                color: Colors.cyan,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TableButton(
                      tableId: 2,
                      onPressed: () {
                        Global.setTableId(2);
                        Get.back();
                        update();
                      },
                    ),
                    TableButton(
                      tableId: 3,
                      onPressed: () {
                        Global.setTableId(3);
                        Get.back();
                        update();
                      },
                    ),
                    TableButton(
                      tableId: 4,
                      onPressed: () {
                        Global.setTableId(4);
                        Get.back();
                        update();
                      },
                    ),
                    TableButton(
                      tableId: 5,
                      onPressed: () {
                        Global.setTableId(5);
                        Get.back();
                        update();
                      },
                    ),
                    TableButton(
                      tableId: 6,
                      onPressed: () {
                        Global.setTableId(6);
                        Get.back();
                        update();
                      },
                    ),
                    TableButton(
                      tableId: 7,
                      onPressed: () {
                        Global.setTableId(7);
                        Get.back();
                        update();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Global.getAssetImageUrl("background.png")),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Text(
              "Table $tableId",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 300.sp,
                decoration: TextDecoration.none,
                fontFamily: 'Burbank',
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TableButton extends StatelessWidget {
  TableButton({Key? key, required this.tableId, required this.onPressed}) : super(key: key);
  final int tableId;
  final showRepository = GameShowRepository();
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.w,
      width: 400.w,
      color: Colors.grey,
      child: TextButton(
        onPressed: onPressed,
        child: Text("Table $tableId"),
      ),
    );
  }
}
