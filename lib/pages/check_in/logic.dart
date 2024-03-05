import 'dart:convert';

import 'package:get/get.dart';
import 'package:interactive_board/pages/check_in/data/single_player.dart';
import '../../common.dart';
import 'data/avatar_info.dart';
import 'data/checkin_api.dart';
import 'data/user_info.dart';

enum PageState { setAvatarPage, addPlayerPage }

class CheckInLogic extends GetxController {
  final checkInApi = CheckInApi();
  // String get gameName => GameShowRepository().gameName!;
  List<UserInfo> userList = [];
  List<ResourceInfo> avatarInfo = [];
  // Map<String,dynamic> singlePlayer = {};
  Map singlePlayer = {};
  bool isCheckIn = false;
  String currentNickName = "";
  String isAvatarType = "head";
  String headId = "";
  bool currentIsMale = true;
  String currentUrl = "";
  bool checkinBtnIsDown = false;
  bool isUpdateName = false;
  // 设置avatar中的返回上一页按钮是否按下
  bool addGoBackIsDown = false;
  // 保存avatar按钮是否按下
  bool saveAvatarIsDown = false;
  // 设置group的按钮是否输入
  bool groupSettingBtnIsInput = false;
  // 是否是第一次进行签到
  bool isFirstCheckIn = true;
  // 是否点击了跳过按钮
  bool isClickSkip = false;

  String? selectedId;

  PageState pageState = PageState.setAvatarPage;

  String birthdayStr = "Please select a date";

  String email = "";
  String phone = "";
  String firstName = "";
  String lastName = "";
  String countryName = "";

  int playerNum = 0;

  // void clickItem(String id, String nickname, String avatarUrl, bool isMale) async {
  void clickItem(String id, String nickname, String avatarUrl, String isMale) async {
    print("点击了item");
    print("123 $selectedId");
    print("123 $id");
    print("123 $nickname");
    print("123 $avatarUrl");
    print("123 $isMale");
    currentNickName = nickname;
    if (id == selectedId) {
      selectedId = null;
    } else {
      selectedId = id;
    }
    // userList = await checkInApi.fetchUsers();
    // avatarInfo = await checkInApi.fetchAvatars();
    update();

    currentIsMale = isMale == "Male" ? true : false;
    update(['bodyPage']);
    currentUrl = avatarUrl;
    update(['headPage']);
  }

  void isUpdateNameFun(bool t) {
    isUpdateName = t;
    // update();
    // update(['setNickname']);
    update(['editNickname']);
  }

  void testUpd(String text) {
    print("$text");
    final index =
        userList.indexWhere((element) => selectedId != null ? element.id == selectedId : element.id == userList[0].id);
    userList[index] = UserInfo(
      id: userList[index].id,
      nickname: text,
      avatarUrl: currentUrl,
      // username: userList[index].username,
      // isMale: currentIsMale,
      headgearId: headId,
      headgearName: userList[index].headgearName,
      bodyId: userList[index].bodyId,
      bodyName: userList[index].bodyName,
    );
    isUpdateName = false;
    currentNickName = text;

    update();
    // update(['setNickname']);
    update(['editNickname']);
  }

  void checkinBtnDown(bool sign) {
    print("切换");
    print("12345: $sign");
    checkinBtnIsDown = sign;
    update(['checkIn']);
  }
  // 返回按钮是否按下
  void goBackBtnDown(bool sign) {
    print("12345: $sign");
    addGoBackIsDown = sign;
    update(['goBackBtn']);
  }
  // 保存avatar是否按下
  void saveAvatarBtnDown(bool sign) {
    print("12345: $sign");
    saveAvatarIsDown = sign;
    update(['saveAvatarBtn']);
  }

  void clickHead(String id, String transparentBackgroundUrl) {
    print("点击了头像");
    print("头像的id: $id");
    print("头像的id: $transparentBackgroundUrl");
    headId = id;
    currentUrl = transparentBackgroundUrl;
    update(['headPage']);
  }

  void clickBody(bool gender) {
    print("点击了身体");
    print("身体的id: $gender");
    currentIsMale = gender;
    update(['bodyPage']);
  }

  void clickCut(String type) {
    print("切换");
    print("12345: $type");
    isAvatarType = type;
    update(['typePage']);
  }

  void checkInFun(bool isClick) async {
    print("调用了");
    // update(["avatarSelect"]);
    if (isClick) {
      isCheckIn = true;
    } else {
      isCheckIn = false;
    }
    // isCheckIn = true;
    update();
  }

  // void testSave() async {
  //   print("呱呱呱呱呱呱: $currentUrl");
  //   checkInApi.updatePlayerInfo(
  //       selectedId ?? (userList[0].id), currentNickName, headId, currentIsMale);
  //   update();
  // }

  void birdShow() {
  }

  void updateUserList() async {
    userList = await checkInApi.fetchUsers();
    update();
  }

  // 点击add player按钮
  void clickAddPlayer() {
    print("呵呵呵呵呵呵呵");
    pageState = PageState.addPlayerPage;
    update(['avatarHomePage']);
  }

  // 点击Done按钮
  void clickDone() {
    print("呃呃呃呃呃呃");
    pageState = PageState.setAvatarPage;
    update(['avatarHomePage']);
  }

  @override
  void onInit() async {
    super.onInit();
    userList = await checkInApi.fetchUsers();
    print(await checkInApi.fetchAvatars());
    print(await checkInApi.fetchBodies());
    print("用户数据: $userList");
    // currentNickName = userList[userList.length - 1].nickname;
    // currentIsMale = userList[0].isMale;
    currentIsMale = userList[0].bodyName == 'Male' ? true : false;
    headId = userList[0].headgearId;
    avatarInfo = await checkInApi.fetchAvatars();
    singlePlayer = await checkInApi.fetchSingleUsers(userList[0].id);
    print("单用户: ${singlePlayer}");
    // print("单用户: ${singlePlayer['id']}");
    final avatar = avatarInfo.firstWhere((element) => element.id == headId);
    print("gfgfgfg: $avatar");
    currentUrl = avatar.url;
    print("头像: $avatarInfo");
    // checkInApi.updatePlayer(68, "abc",3,1);
  }

}
