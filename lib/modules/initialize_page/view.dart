import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:interactive_board/modules/initialize_page/logic.dart';
import '../../common.dart';

class InitializePage extends StatelessWidget {
  InitializePage({Key? key}) : super(key: key);
  final logic = Get.find<InitializeLogic>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Global.getAssetImageUrl("background.png")),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [1, 2, 3, 4, 5, 6, 7, 8]
                .map(
                  (e) => _TableButton(
                    tableId: e,
                    onPressed: () {
                      logic.setTableId(e);
                    },
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class _TableButton extends StatelessWidget {
  _TableButton({
    Key? key,
    required this.tableId,
    required this.onPressed,
  }) : super(key: key);
  final int tableId;
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
