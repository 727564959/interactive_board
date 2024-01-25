import 'dart:convert';

import 'package:get/get.dart';
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

  String? selectedId;

  PageState pageState = PageState.setAvatarPage;

  // void clickItem(String id, String nickname, String avatarUrl, bool isMale) async {
  void clickItem(String id, String nickname, String avatarUrl, String isMale) async {
    print("点击了item");
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
    update();
    update(['setNickname']);
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
    update(['setNickname']);
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
    currentNickName = userList[0].nickname;
    // currentIsMale = userList[0].isMale;
    currentIsMale = userList[0].bodyName == 'Male' ? true : false;
    headId = userList[0].headgearId;
    avatarInfo = await checkInApi.fetchAvatars();
    final avatar = avatarInfo.firstWhere((element) => element.id == headId);
    currentUrl = avatar.url;
    print("头像: $avatarInfo");
  }

}
