import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../mirra_style.dart';
import '../../data/model/show_state.dart';
import '../../widgets/check_in_title.dart';
import '../../widgets/common_button.dart';
import '../check_in/data/show.dart';
import '../check_in/data/skin_gender_option.dart';
import '../check_in/home_page/booking_state.dart';
import '../check_in/player_page/logic.dart';
import '../check_in/player_page/player_squad.dart';
import '../table_check/player_show/logic.dart';
import '../table_check/player_show/view.dart';
import 'data/player_card.dart';
import 'logic.dart';

class PlayerLookPage extends StatelessWidget {
  PlayerLookPage({Key? key}) : super(key: key);
  final logic = Get.put(MirraLookLogic());
  int get tableId => Get.arguments["tableId"];
  ShowInfo get showInfo => Get.arguments?["showInfo"];
  // Customer get customer => Get.arguments?["customer"];
  BookingState get bookingState => Get.arguments?["bookingState"];
  Customer get customer => bookingState.customer;
  bool get isAddPlayerClick => Get.arguments?["isAddPlayerClick"];
  PlayerCardInfo get card => Get.arguments?["card"];
  ShowState get showState => Get.arguments?["showState"];

  late FToast fToast = FToast();
  void showCustomToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xFF7B7B7B),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error, color: Colors.black, size: 24,),
          SizedBox(
            width: 12.0,
          ),
          RichText(
            text: TextSpan(
              text: "Oops! That nickname doesn't seem quite right.\n",
              style: CustomTextStyles.title(color: Color(0xffFFFFFF), fontSize: 26.sp, level: 4),
              children: <TextSpan>[
                TextSpan(
                  text: "Let's try another one.",
                  style: CustomTextStyles.title(color: Color(0xffFFFFFF), fontSize: 26.sp, level: 4),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    fToast.showToast(
      // child: toast,
      child: Transform.translate(
        offset: Offset(0, 36.0), // 调整垂直方向上的偏移量
        child: toast,
      ),
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<MirraLookLogic>(
            id: "playerLookPage",
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 1.0.sw,
                        child: GetBuilder<MirraLookLogic>(
                          builder: (logic) {
                            return Column(
                              children: [
                                // 顶部文本信息
                                CheckInTitlePage(titleText: "Mirra Look", tableId: tableId),
                                SizedBox(height: 20,),
                                _PlayerInfoArea(),
                                SizedBox(height: 30,),
                                SizedBox(
                                  width: 1.0.sw,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Container(
                                      //   margin: EdgeInsets.only(left: 40.0),
                                      //   child: Column(
                                      //     crossAxisAlignment: CrossAxisAlignment.start,
                                      //     children: [
                                      //       Text(
                                      //         "After saving,",
                                      //         style: CustomTextStyles.textSmall(color: Colors.white, fontSize: 30.sp),
                                      //       ),
                                      //       Text(
                                      //         "changes apply in the next game.",
                                      //         style: CustomTextStyles.textSmall(color: Colors.white, fontSize: 30.sp),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                      Container(
                                        margin: EdgeInsets.only(right: 40.0),
                                        // child: _SaveButton(width: 317.w,),
                                        child: CommonButton(
                                          width: 317.w,
                                          height: 100.h,
                                          btnText: "SAVE",
                                          // btnBgColor: Color(0xFF272727),
                                          textColor: Color(0xff13EFEF),
                                          onPress: () async {
                                            EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
                                            try {
                                              Map sensitiveWordDetector = await logic.sensitiveWordDetector(logic.currentName);
                                              if(sensitiveWordDetector['pass']) {
                                                logic.updateUserPreference(card.userId??0, logic.currentName, Get.arguments["gameItemInfo"][logic.clickedCard??0].id, logic.selectedGender.label??"", logic.selectedSkin.label??"");
                                              }
                                              else {
                                                showCustomToast();
                                                EasyLoading.dismiss(animation: false);
                                                return;
                                              }
                                              // logic.updateUserPreference(card.userId??0, logic.currentName, Get.arguments["gameItemInfo"][logic.clickedCard??0].id, logic.selectedGender.label??"", logic.selectedSkin.label??"");
                                              EasyLoading.dismiss(animation: false);
                                              if(Get.arguments["showInfo"] != null) {
                                                Future.delayed(0.5.seconds).then((value) async {
                                                  Get.offAll(() => PlayerSquadPage(),
                                                      arguments: {
                                                        "showInfo": showInfo,
                                                        "bookingState": bookingState,
                                                        "isAddPlayerClick": false,
                                                        "isCountdownStart": true,
                                                        "tableId": tableId,
                                                      });
                                                });
                                                print("哈哈哈哈哈 ${Get.isRegistered<PlayerShowLogic>()}");
                                                if(Get.isRegistered<PlayerShowLogic>()) {
                                                  Get.find<PlayerShowLogic>().isCountdownStart = true;
                                                  Get.find<PlayerShowLogic>().getPlayerCardInfo(showInfo.showId);
                                                }
                                              }
                                              else {
                                                Future.delayed(0.5.seconds).then((value) async {
                                                  Get.offAll(() => PlayerShowPage(),
                                                      arguments: {
                                                        'showState': showState,
                                                      });
                                                });
                                                print("嘿嘿嘿嘿 ${Get.isRegistered<PlayerShowPageLogic>()}");
                                                if(Get.isRegistered<PlayerShowPageLogic>()) {
                                                  Get.find<PlayerShowPageLogic>().getPlayerCardInfo(showState.showId);
                                                }
                                              }
                                            } on DioException catch (e) {
                                              EasyLoading.dismiss();
                                              if (e.response == null) EasyLoading.showError("Network Error!");
                                              EasyLoading.showError(e.response?.data["error"]["message"]);
                                            }
                                          },
                                          borderColor: Color(0xff13EFEF),
                                          changedBorderColor: Color(0xffA4EDF1),
                                          changedTextColor: Color(0xffA4EDF1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// class SkinOption {
//   final Color color;
//   final String label;
//   SkinOption({required this.color, required this.label});
// }
// class GenderOption {
//   final Color color;
//   final String label;
//   GenderOption({required this.color, required this.label});
// }
class _PlayerInfoArea extends StatefulWidget {
  @override
  _PlayerInfoAreaState createState() => _PlayerInfoAreaState();
}

class _PlayerInfoAreaState extends State<_PlayerInfoArea> {
  final logic = Get.put(MirraLookLogic());
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
  // 浅色
  Color get lightColor {
    if (tableId == 1) {
      return const Color(0xFFE6BC9C);
    } else if (tableId == 2) {
      return const Color(0xFFE8B6E0);
    } else if (tableId == 3) {
      return const Color(0xFFBCDBBC);
    } else {
      return const Color(0xFFC5D4E6);
    }
  }
  // 深色
  Color get darkColor {
    if (tableId == 1) {
      return const Color(0xFFCB8C5E);
    } else if (tableId == 2) {
      return const Color(0xFFBB7EB1);
    } else if (tableId == 3) {
      return const Color(0xFF81AE81);
    } else {
      return const Color(0xFF85AEDE);
    }
  }

  // SkinOption? selectedSkin;
  // GenderOption? selectedGender;
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
  PlayerCardInfo get card => Get.arguments["card"];

  @override
  void initState() {
    super.initState();
    for(int i = 0; i < skinOptions.length; i++) {
      if(card.skinColor == skinOptions[i].label) {
        logic.selectedSkin = skinOptions[i];
      }
    }
    for(int j = 0; j < genderOptions.length; j++) {
      if(card.sex == genderOptions[j].label) {
        logic.selectedGender = genderOptions[j];
      }
    }
    print("触发了吗");
    print("gameItemInfo ${Get.arguments["gameItemInfo"]}");
    for(int i = 0; i < Get.arguments["gameItemInfo"].length; i++) {
      if(Get.arguments["gameItemInfo"][i].id == card.avatarId) {
        logic.clickedCard = i;
      }
    }
  }

  // 肤色
  Widget buildSkinOption(SkinOption option) {
    // for(int i = 0; i < skinOptions.length; i++) {
    //   if(card.skinColor == skinOptions[i].label) {
    //     logic.selectedSkin = skinOptions[i];
    //   }
    // }
    bool isSelected = option == logic.selectedSkin;
    return GestureDetector(
      onTap: () {
        setState(() {
          logic.selectedSkin = option;
        });
      },
      // child: Container(
      //   width: 110,
      //   height: 110,
      //   decoration: BoxDecoration(
      //     shape: BoxShape.circle,
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
        width: 110,
        height: 110,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: option.color,
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
    // for(int j = 0; j < genderOptions.length; j++) {
    //   if(card.sex == genderOptions[j].label) {
    //     logic.selectedGender = genderOptions[j];
    //   }
    // }
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
        width: 110,
        height: 110,
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
      //   width: 110,
      //   height: 110,
      //   decoration: BoxDecoration(
      //     // shape: BoxShape.circle,
      //     borderRadius: BorderRadius.all(Radius.circular(10)),
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
      //         Text(
      //           option.label??"",
      //           textAlign: TextAlign.center,
      //           style: CustomTextStyles.title(color: Colors.black, fontSize: 26.sp, level: 5),
      //         ),
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
    // TextEditingController _nameTextFieldController = new TextEditingController(text: "Tom");
    return Container(
      width: 0.9.sw,
      height: 0.65.sh,
      margin: EdgeInsets.only(left: 0.0.sw),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 左右布局: 左侧姓名
          Container(
            width: 0.25.sw,
            decoration: BoxDecoration(
              color: Color(0xffFFFFFF).withOpacity(0.08),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // 子项垂直居中对齐
              children: [
                Container(
                  height: 60.0,
                  width: 0.22.sw,
                  child: _NicknamePage(),
                  // child: TextField(
                  //   controller: _nameTextFieldController,
                  //   textAlign: TextAlign.center,
                  //   decoration: InputDecoration(
                  //     border: InputBorder.none,
                  //     fillColor: Color(0xFF5E6F96),
                  //     filled: true,
                  //     suffixIcon: Icon(Icons.edit, color: Colors.white, size: 35,),
                  //     contentPadding: EdgeInsets.symmetric(vertical: 30.sp, horizontal: 0.sp),
                  //   ),
                  //   inputFormatters: [
                  //     LengthLimitingTextInputFormatter(15),
                  //     FilteringTextInputFormatter.allow(
                  //       RegExp(r'[A-Za-z0-9]+'),
                  //     )
                  //   ],
                  //   onChanged: (v) {
                  //     print("onChange: $v");
                  //     // logic.currentNickName = v;
                  //   },
                  //   style: CustomTextStyles.title(color: Color(0xffFFFFFF), fontSize: 48.sp, level: 2),
                  // ),
                  // child: Text(
                  //   "Tom",
                  //   style: CustomTextStyles.title(color: Color(0xffFFFFFF), fontSize: 48.sp, level: 2),
                  // ),
                ),
                // SizedBox(
                //   child: Icon(Icons.edit, color: Colors.white, size: 35,),
                // ),
              ],
            ),
          ),
          // 左右布局: 右侧头像,皮肤,性别
          SizedBox(
            width: 0.64.sw,
            child: Column(
              children: [
                Container(
                  width: 0.64.sw,
                  height: 0.35.sh,
                  decoration: BoxDecoration(
                    color: Color(0xffFFFFFF).withOpacity(0.08),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 60,
                        margin: EdgeInsets.only(left: 30.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Headgear",
                            textAlign: TextAlign.left,
                            style: CustomTextStyles.title(color: Colors.white, fontSize: 32.sp, level: 4),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20.0),
                        height: 0.35.sh - 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: Get.arguments["gameItemInfo"].length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                print("点击了卡牌");
                                print("索引位 ${index}");
                                setState(() {
                                  logic.clickedCard = index;
                                });
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 10.0),
                                    width: 140,
                                    height: 196,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        // gradient: RadialGradient(
                                        //   center: Alignment.center,
                                        //   radius: 0.5,
                                        //   colors: [
                                        //     lightColor.withOpacity(1.0), // 设置渐变起始颜色并设置透明度
                                        //     darkColor.withOpacity(1.0), // 设置渐变结束颜色并设置透明度
                                        //   ],
                                        // ),
                                        color: color,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // margin: EdgeInsets.only(top: 10.0),
                                            decoration: BoxDecoration(
                                              // borderRadius: BorderRadius.all(Radius.circular(10)),
                                              borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              ),
                                              gradient: RadialGradient(
                                                center: Alignment.center,
                                                radius: 0.5,
                                                colors: [
                                                  lightColor.withOpacity(1.0), // 设置渐变起始颜色并设置透明度
                                                  darkColor.withOpacity(1.0), // 设置渐变结束颜色并设置透明度
                                                ],
                                              ),
                                            ),
                                            child: CachedNetworkImage(
                                              height: 153,
                                              imageUrl: Get.arguments["gameItemInfo"][index].icon,
                                              // fit: BoxFit.fitWidth,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Container(
                                            height: 2.0,
                                            color: Colors.white,
                                          ),
                                          if(Get.arguments["gameItemInfo"].length > 5 && index > 4) Text(
                                            "LIMITED",
                                            style: TextStyle(
                                              fontFamily: 'Anton',
                                              fontSize: 20.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          if(Get.arguments["gameItemInfo"].length <= 5 || index < 5) Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: List.generate(Get.arguments["gameItemInfo"][index].level + 2, (i) {
                                                return Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 2), // 设置左右间距
                                                  child: Image.asset(
                                                    MirraIcons.getSetAvatarIconPath('level_star_icon.png'),
                                                    fit: BoxFit.contain,
                                                    width: 20,
                                                  ),
                                                );
                                              }),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  if(index == logic.clickedCard) Positioned(
                                    top: 5,
                                    right: 15,
                                    child: Image.asset(
                                      MirraIcons.getSetAvatarIconPath('choose_icon.png'),
                                      fit: BoxFit.fitWidth,
                                      width: 32,
                                    ),
                                  ),
                                ],
                              ),

                            );
                          }
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 0.015.sh,),
                SizedBox(
                  width: 0.64.sw,
                  height: 0.285.sh,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 0.38.sw,
                        decoration: BoxDecoration(
                          color: Color(0xffFFFFFF).withOpacity(0.08),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 60,
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
                      Container(
                        width: 0.25.sw,
                        decoration: BoxDecoration(
                          color: Color(0xffFFFFFF).withOpacity(0.08),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 60,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NicknamePage extends StatefulWidget {
  @override
  _NicknamePageState createState() => _NicknamePageState();
}
class _NicknamePageState extends State<_NicknamePage> {
  PlayerCardInfo get card => Get.arguments["card"];
  final logic = Get.put(MirraLookLogic());
  bool isFocused = false;
  final FocusNode focusNode = FocusNode();

  late FToast fToast;

  @override
  void initState() {
    super.initState();
    logic.currentName = card.nickname??"";
    logic.nameTextFieldController.text = card.nickname??"";
    focusNode.addListener(() {
      setState(() {
        isFocused = focusNode.hasFocus;
      });
      if (focusNode.hasFocus) {
        logic.nameTextFieldController.selection = TextSelection.fromPosition(
          TextPosition(offset: logic.nameTextFieldController.text.length),
        );
      }
    });
    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TextEditingController _nameTextFieldController = new TextEditingController(text: logic.currentName);
    return TextField(
      // controller: _nameTextFieldController,
      controller: logic.nameTextFieldController,
      cursorWidth: 3.0,          // 光标粗细
      cursorRadius: Radius.circular(3.0), // 使用Radius.circular设置圆形半径
      cursorColor: Colors.white,   // 光标颜色
      cursorHeight: 36.0, // 设置光标的高度，与文字的字体大小一致
      maxLines: 1,
      focusNode: focusNode,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: Color(0xFF5E6F96),
        filled: true,
        suffixIcon: isFocused ? null : Icon(Icons.edit, color: Colors.white, size: 35,),
        contentPadding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 5.sp),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(15),
        FilteringTextInputFormatter.allow(
          RegExp(r'[A-Za-z0-9]+'),
        )
      ],
      onChanged: (v) {
        print("onChange: $v");
        logic.currentName = v;
      },
      style: CustomTextStyles.title(color: Color(0xffFFFFFF), fontSize: 36.sp, level: 4),
    );
  }
}