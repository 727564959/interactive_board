import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common.dart';
import '../../../../mirra_style.dart';
import '../../../widgets/common_button.dart';
import '../../add_player/input_nickname.dart';
import '../data/show.dart';
import '../data/skin_gender_option.dart';
import '../data/user_info.dart';
import '../home_page/booking_state.dart';
import 'logic.dart';
import 'player_squad.dart';

class NewPlayerPage extends StatelessWidget {
  NewPlayerPage({Key? key}) : super(key: key);
  final logic = Get.put(PlayerShowLogic());
  int get tableId => Get.arguments["tableId"];
  ShowInfo get showInfo => Get.arguments["showInfo"];
  BookingState get bookingState => Get.arguments["bookingState"];
  Customer get customer => bookingState.customer;
  bool get isAddPlayerClick => Get.arguments["isAddPlayerClick"];
  int get userId => Get.arguments["userId"];
  int get headgearId => Get.arguments["headgearId"];

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
                    // Container(
                    //   width: 0.9.sw,
                    //   margin: EdgeInsets.only(top: 40.0, left: 0.1.sw),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text(
                    //         "Skin & Gender",
                    //         style: CustomTextStyles.title(color: Colors.white, fontSize: 48.sp, level: 2),
                    //       ),
                    //       SizedBox(height: 10,),
                    //       Text(
                    //         "Time to Shine! Design Your Mirra Look.",
                    //         style: CustomTextStyles.title(color: Colors.white, fontSize: 36.sp, level: 4),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0, left: 40.0),
                      constraints: BoxConstraints.tightFor(width: (1.0.sw - 40)), //卡片大小
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              "Skin & Gender",
                              style: CustomTextStyles.title(color: Colors.white, fontSize: 48.sp, level: 2),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: Text(
                              "Time to Shine! Design Your Mirra Look.",
                              style: CustomTextStyles.textSmall(
                                color: Color(0xFFFFFFFF),
                                fontSize: 26.sp,),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _SelectedArea(),
                    SizedBox(height: 50,),
                    // _SaveButton(width: 600.w),
                    CommonButton(
                      width: 600.w,
                      height: 100.h,
                      btnText: 'SAVE',
                      btnBgColor: Color(0xff13EFEF),
                      textColor: Colors.black,
                      onPress: () async {
                        if(logic.selectedGender.label != null && logic.selectedSkin.label != null) {
                          try {
                            final player = await logic.fetchUserAvatar(userId);
                            logic.updateUserPreference(player.id, player.nickname, headgearId, logic.selectedGender.label??"", logic.selectedSkin.label??"");
                            logic.testFun();
                            EasyLoading.dismiss(animation: false);
                            // Get.to(() => PlayerSquadPage(),
                            //     arguments: {
                            //       "showInfo": showInfo,
                            //       "bookingState": bookingState,
                            //       "isAddPlayerClick": isAddPlayerClick,
                            //       "tableId": tableId,
                            //     });
                            // Get.to(() => InputNicknamePage(),
                            //     arguments: {
                            //       "showInfo": showInfo,
                            //       "bookingState": bookingState,
                            //       "isAddPlayerClick": isAddPlayerClick,
                            //       "tableId": tableId,
                            //       "isFlow": "checkIn",
                            //       "userId": userId
                            //     });
                            Get.offAll(() => PlayerSquadPage(),
                                arguments: {
                                  'showInfo': showInfo,
                                  "bookingState": bookingState,
                                  // "isAddPlayerClick": logic.casualUser.length < bookingState.quantity ? true : false,
                                  "isAddPlayerClick": true,
                                  "tableId": tableId,
                                });
                          } on DioException catch (e) {
                            EasyLoading.dismiss();
                            if (e.response == null) EasyLoading.showError("Network Error!");
                            EasyLoading.showError(e.response?.data["error"]["message"]);
                          }
                        }
                        else {
                          EasyLoading.showError("Please fill in the information !");
                        }
                      },
                      changedBgColor: Color(0xffA4EDF1),
                    ),
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
  UserInfo get userData => Get.arguments?["userData"];

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

  @override
  void initState() {
    super.initState();
    print("userData ${userData.skinColor}");
    for(int i = 0; i < skinOptions.length; i++) {
      if(userData.skinColor == skinOptions[i].label) {
        logic.selectedSkin = skinOptions[i];
      }
    }
    print("logic.selectedSkin ${logic.selectedSkin}");
    for(int j = 0; j < genderOptions.length; j++) {
      if(userData.sex == genderOptions[j].label) {
        logic.selectedGender = genderOptions[j];
      }
    }
  }

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
    // 根据 option 中的参数选择不同的图片
    String imagePath;
    switch (option.label) {
      case 'male':
        imagePath = MirraIcons.getSetAvatarIconPath("male.png");
        break;
      default:
        imagePath = MirraIcons.getSetAvatarIconPath("female.png");
    }

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
          color: option.color,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          image: DecorationImage(
            image: AssetImage(imagePath), // 根据 option 选择的图片
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // 如果未选择时显示其他内容（可选）
            // 你也可以在这里添加其他组件
            if (isSelected)
              Positioned(
                right: 5, // 右侧距离
                bottom: 5, // 底部距离
                child: Container(
                  width: 36, // 设置宽度
                  height: 36, // 设置高度
                  child: Image.asset(
                    MirraIcons.getSetAvatarIconPath('choose_icon.png'),
                    fit: BoxFit.cover, // 根据需要选择其他 fit 值
                  ),
                ),
              ),
          ],
        ),
      ),
      // child: Container(
      //   width: 125,
      //   height: 125,
      //   decoration: BoxDecoration(
      //     // shape: BoxShape.circle,
      //     borderRadius: BorderRadius.all(Radius.circular(15)),
      //     color: option.color,
      //     // color: isSelected ? Color(0xffFFFFFF).withOpacity(0.08) : Color(0xffFFFFFF).withOpacity(0.0),
      //     // border: Border.all(
      //     //   color: isSelected ? Color(0xFFD0D0D0) : Colors.transparent,
      //     //   width: isSelected ? 4.0 : 0.0,
      //     // ),
      //   ),
      //   child: Align(
      //     alignment: Alignment.center,
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center, // 子项垂直居中对齐
      //       children: [
      //         isSelected ? Image.asset(
      //           MirraIcons.getSetAvatarIconPath('choose_icon.png'),
      //           fit: BoxFit.fitWidth,
      //           width: 48,
      //         ) : SizedBox(height: 48,),
      //         // Text(
      //         //   option.label??"",
      //         //   textAlign: TextAlign.center,
      //         //   style: CustomTextStyles.title(color: Colors.black, fontSize: 26.sp, level: 5),
      //         // ),
      //       ],
      //     ),
      //   ),
      //   // padding: EdgeInsets.all(5.0), // 调整内部圆形与外边界之间的距离
      //   // child: Container(
      //   //   decoration: BoxDecoration(
      //   //     // shape: BoxShape.circle,
      //   //     borderRadius: BorderRadius.all(Radius.circular(10)),
      //   //     color: option.color,
      //   //   ),
      //   //   child: Center(
      //   //     child: Text(
      //   //       option.label,
      //   //       textAlign: TextAlign.center,
      //   //       style: CustomTextStyles.title(color: Colors.black, fontSize: 26.sp, level: 5),
      //   //     ),
      //   //   ),
      //   // ),
      // ),
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
            // height: 290,
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
                      "Body",
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
