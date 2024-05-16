import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common.dart';
import '../../../../mirra_style.dart';
import '../data/booking.dart';
import '../data/show.dart';
import '../data/skin_gender_option.dart';
import 'logic.dart';
import 'player_squad.dart';

class NewPlayerPage extends StatelessWidget {
  NewPlayerPage({Key? key}) : super(key: key);
  final logic = Get.put(PlayerShowLogic());
  int get tableId => Get.arguments["tableId"];

  Color get color {
    if (tableId == 1) {
      // background: #FFBD80;
      return const Color(0xFFFFBD80);
    } else if (tableId == 2) {
      // background: #EFB5FD;
      return const Color(0xFFEFB5FD);
    } else if (tableId == 3) {
      // background: #8EE8BD;
      return const Color(0xFF8EE8BD);
    } else {
      // background: #9ED7F7;
      return const Color(0xFF9ED7F7);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<PlayerShowLogic>(
            id: "newPlayerPage",
            builder: (logic) {
              return Container(
                width: 1.0.sw,
                height: 1.0.sh,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(MirraIcons.getSetAvatarIconPath("interactive_board_bg.png")),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 0.9.sw,
                      margin: EdgeInsets.only(top: 40.0, left: 0.1.sw),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Skin & Gender",
                            style: CustomTextStyles.title(color: Colors.white, fontSize: 48.sp, level: 2),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "Time to Shine! Design Your Mirra Look.",
                            style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
                          ),
                        ],
                      ),
                    ),
                    _SelectedArea(),
                    SizedBox(height: 50,),
                    _SaveButton(width: 600.w),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SelectedArea extends StatefulWidget {
  @override
  _SelectedAreaState createState() => _SelectedAreaState();
}

class _SelectedAreaState extends State<_SelectedArea> {
  final logic = Get.put(PlayerShowLogic());

  List<SkinOption> skinOptions = [
    SkinOption(color: Color(0xFFFFF3E0), label: 'white'),
    SkinOption(color: Color(0xFFEBD4B1), label: 'yellow'),
    SkinOption(color: Color(0xFFB68D67), label: 'brown'),
    SkinOption(color: Color(0xFF352920), label: 'black'),
  ];
  List<GenderOption> genderOptions = [
    GenderOption(color: Color(0xFF6CC1FF), label: 'male'),
    GenderOption(color: Color(0xFFFF9AE9), label: 'female'),
  ];
  // 肤色
  Widget buildSkinOption(SkinOption option) {
    bool isSelected = option == logic.selectedSkin;
    return GestureDetector(
      onTap: () {
        setState(() {
          logic.selectedSkin = option;
        });
      },
      // child: Container(
      //   width: 125,
      //   height: 125,
      //   decoration: BoxDecoration(
      //     shape: BoxShape.circle,
      //     // color: option.color,
      //     color: isSelected ? Color(0xffFFFFFF).withOpacity(0.08) : Color(0xffFFFFFF).withOpacity(0.0),
      //     border: Border.all(
      //       color: isSelected ? Color(0xFFD0D0D0) : Colors.transparent,
      //       width: isSelected ? 4.0 : 0.0,
      //     ),
      //   ),
      //   padding: EdgeInsets.all(5.0), // 调整内部圆形与外边界之间的距离
      //   child: Container(
      //     decoration: BoxDecoration(
      //       shape: BoxShape.circle,
      //       color: option.color,
      //     ),
      //   ),
      // ),
      child: Container(
        width: 125,
        height: 125,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: option.color,
          // border: Border.all(
          //   color: isSelected ? Colors.white : Colors.transparent,
          //   width: isSelected ? 4.0 : 0.0,
          // ),
        ),
        child: isSelected ? Center(
          child: Image.asset(
            MirraIcons.getSetAvatarIconPath('choose_icon.png'),
            fit: BoxFit.fitWidth,
            width: 48,
          ),
        ) : null,
      ),
    );
  }
  // 性别
  Widget buildGenderOption(GenderOption option) {
    bool isSelected = option == logic.selectedGender;
    return GestureDetector(
      onTap: () {
        setState(() {
          logic.selectedGender = option;
        });
      },
      child: Container(
        width: 125,
        height: 125,
        decoration: BoxDecoration(
          // shape: BoxShape.circle,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: option.color,
          // color: isSelected ? Color(0xffFFFFFF).withOpacity(0.08) : Color(0xffFFFFFF).withOpacity(0.0),
          // border: Border.all(
          //   color: isSelected ? Color(0xFFD0D0D0) : Colors.transparent,
          //   width: isSelected ? 4.0 : 0.0,
          // ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 子项垂直居中对齐
            children: [
              isSelected ? Image.asset(
                MirraIcons.getSetAvatarIconPath('choose_icon.png'),
                fit: BoxFit.fitWidth,
                width: 48,
              ) : SizedBox(height: 48,),
              Text(
                option.label??"",
                textAlign: TextAlign.center,
                style: CustomTextStyles.title(color: Colors.black, fontSize: 26.sp, level: 5),
              ),
            ],
          ),
        ),
        // padding: EdgeInsets.all(5.0), // 调整内部圆形与外边界之间的距离
        // child: Container(
        //   decoration: BoxDecoration(
        //     // shape: BoxShape.circle,
        //     borderRadius: BorderRadius.all(Radius.circular(10)),
        //     color: option.color,
        //   ),
        //   child: Center(
        //     child: Text(
        //       option.label,
        //       textAlign: TextAlign.center,
        //       style: CustomTextStyles.title(color: Colors.black, fontSize: 26.sp, level: 5),
        //     ),
        //   ),
        // ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.9.sw,
      height: 0.5.sh,
      margin: EdgeInsets.only(left: 0.1.sw),
      child: Row(
        children: [
          Container(
            width: 0.48.sw,
            height: 240,
            decoration: BoxDecoration(
              color: Color(0xffFFFFFF).withOpacity(0.08),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                  margin: EdgeInsets.only(left: 30.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Skin",
                      textAlign: TextAlign.left,
                      style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: skinOptions.map(buildSkinOption).toList(),
                ),
              ],
            ),
          ),
          SizedBox(width: 20,),
          Container(
            width: 0.24.sw,
            height: 240,
            decoration: BoxDecoration(
              color: Color(0xffFFFFFF).withOpacity(0.08),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                  margin: EdgeInsets.only(left: 30.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Gender",
                      textAlign: TextAlign.left,
                      style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: genderOptions.map(buildGenderOption).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  _SaveButton({
    Key? key,
    required this.width,
  }) : super(key: key);
  final logic = Get.put(PlayerShowLogic());
  final double width;
  ShowInfo get showInfo => Get.arguments["showInfo"];
  Customer get customer => Get.arguments["customer"];
  bool get isAddPlayerClick => Get.arguments["isAddPlayerClick"];
  int get userId => Get.arguments["userId"];
  int get headgearId => Get.arguments["headgearId"];
  int get tableId => Get.arguments["tableId"];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 点击事件
      onTap: () async {
        if(logic.selectedGender.label != null && logic.selectedSkin.label != null) {

          try {
            final player = await logic.fetchUserAvatar(userId);
            logic.updateUserPreference(player.id, player.nickname, headgearId, logic.selectedGender.label??"", logic.selectedSkin.label??"");
            logic.testFun();
            EasyLoading.dismiss(animation: false);
            Get.to(() => PlayerSquadPage(),
                arguments: {
                  "showInfo": showInfo,
                  "customer": customer,
                  "isAddPlayerClick": isAddPlayerClick,
                  "tableId": tableId,
                });
          } on DioException catch (e) {
            EasyLoading.dismiss();
            if (e.response == null) EasyLoading.showError("Network Error!");
            EasyLoading.showError(e.response?.data["error"]["message"]);
          }

          // final player = await logic.fetchUserAvatar(userId);
          // await Future.delayed(100.ms);
          // logic.updateUserPreference(player.id, player.nickname, headgearId, logic.selectedGender.label??"", logic.selectedSkin.label??"");
          // await Future.delayed(100.ms);
          // // logic.getPlayerCardInfo(showInfo.showId);
          // logic.testFun();
          // await Future.delayed(1000.ms);
          // Get.offAll(() => PlayerSquadPage(), arguments: {"showInfo": showInfo, "customer": customer, "isAddPlayerClick": isAddPlayerClick,});
        }
        else {
          EasyLoading.showError("Please fill in the information !");
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff13EFEF),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        margin: EdgeInsets.only(top: 0.0, left: 0.0),
        constraints: BoxConstraints.tightFor(width: width, height: 100.h),
        child: Center(
          child: Text(
            "SAVE",
            textAlign: TextAlign.center,
            style: CustomTextStyles.button(color: Color(0xff000000), fontSize: 28.sp),
          ),
        ),
      ),
    );
  }
}