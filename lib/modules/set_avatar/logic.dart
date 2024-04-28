import 'dart:convert';

import 'package:get/get.dart';
import 'package:interactive_board/modules/set_avatar/data/new_add_user.dart';
import '../../common.dart';
import '../../data/model/show_state.dart';
import '../../pages/check_in/data/avatar_info.dart';
import 'data/setAvatar_api.dart';
import 'data/user_info.dart';

class SetAvatarLogic extends GetxController {
  final setAvatarApi = SetAvatarApi();

  Map singlePlayer = {};
  List<ResourceInfo> avatarInfo = [];
  // NewAddUser get newAddUser => Get.arguments;
  NewAddUser newAddUser = NewAddUser.fromJson(Get.arguments);
  // NewAddUser newAddUser = NewAddUser(userId: Get.arguments['userId'], showId: Get.arguments['showId'], showStatus: Get.arguments['showStatus']);
  // int consumerId = Get.arguments;
  List<UserInfo> userList = [];
  // 当前队伍能用的头像
  List<GameItemInfo> gameItemInfoHead = [];
  // 当前队伍能用的身体
  List<GameItemInfo> gameItemInfoBody = [];

  String headId = "";
  // bool currentIsMale = true;
  String currentIsMale = "";
  String currentBodyUrl = "";
  String currentUrl = "";
  String currentNickName = "";

  void clickHead(String id, String transparentBackgroundUrl) {
    print("点击了头像");
    print("头像的id: $id");
    print("头像的id: $transparentBackgroundUrl");
    headId = id;
    currentUrl = transparentBackgroundUrl;
    update();
  }

  void clickBody(String id, String transparentBackgroundUrl) {
    print("点击了身体");
    print("身体的id: $id");
    currentIsMale = id;
    currentBodyUrl = transparentBackgroundUrl;
    update();
  }

  // void clickBody(bool gender) {
  //   print("点击了身体");
  //   print("身体的id: $gender");
  //   currentIsMale = gender;
  //   update();
  // }

  void updateUserList(int showId) async {
    print("身体的id: $showId");
    userList = await setAvatarApi.fetchUsers(showId);
    update();
  }

  void updatePlayer(String userId) async {
    print("身体的id: $userId");
    singlePlayer = await setAvatarApi.fetchSingleUsers(userId);
    avatarInfo = await setAvatarApi.fetchAvatars();
    for (int i = 0; i < userList.length; i++) {
      print(userList[i].id);
      if (singlePlayer['id'].toString() == userList[i].id) {
        headId = userList[i].headgearId;
        // currentIsMale = userList[i].bodyName == 'Male' ? true : false;
        // currentIsMale = userList[i].bodyId;
        currentNickName = userList[i].nickname;
        // currentUrl = userList[i].avatarUrl;
      }
    }
    final avatar = avatarInfo.firstWhere((element) => element.id == headId);
    print("gfgfgfg: $avatar");
    currentUrl = avatar.url;
    print("currentUrl ${currentUrl}");
    // currentNickName = singlePlayer['name'];
    // final avatar = avatarInfo.firstWhere((element) => element.id == headId);
    // currentUrl = avatar.url;
    update();
  }

  // 查询当前用户的头套和身体
  void explosiveChestFun(userId) async {
    print("hash说的很好的很好 ${userId}");
    final gameItem = await setAvatarApi.fetchUserGameItems(userId);
    gameItemInfoHead = [];
    gameItemInfoBody = [];
    for(int i = 0; i < gameItem.length; i++) {
      if(gameItem[i].type == "headgear") {
        gameItemInfoHead.add(gameItem[i]);
        // print("爆出来的头像: ${gameItemInfo}");
      }
      if(gameItem[i].type == "body") {
        gameItemInfoBody.add(gameItem[i]);
        // print("爆出来的头像: ${gameItemInfo}");
      }
    }
    // gameItemInfo = await checkInApi.fetchUserGameItems(userId);
    print("爆出来的头像: ${gameItemInfoHead}");
    print("爆出来的身体: ${gameItemInfoBody}");
    print("哈哈哈哈: ${headId}");
    print("currentIsMale: ${currentIsMale}");
    final bodyInfo = gameItemInfoBody.firstWhere((element) => element.id.toString() == currentIsMale);
    print("bodyInfo: ${bodyInfo}");
    currentBodyUrl = bodyInfo.icon;
    print("currentBodyUrl: ${currentBodyUrl}");

    // final avatar = gameItemInfoHead.firstWhere((element) => element.id.toString() == headId);
    // currentUrl = avatar.icon;
    // 刷新当前页面
    update();
  }

  @override
  void onReady() async {
    print('onReady called');
    super.onReady();
    updateUserList(Get.arguments['showId']);
    updatePlayer(Get.arguments['userId'].toString());
    explosiveChestFun(Get.arguments['userId']);
  }

  @override
  void onInit() async {
    super.onInit();
    // await Future.delayed(100.ms);
    print("需要展示的玩家ID: $newAddUser");
    print("需要展示的玩家ID: ${newAddUser.userId}");
    print("状态值ID: ${newAddUser.status}");
    userList = await setAvatarApi.fetchUsers(newAddUser.showId ?? 1);
    print("当桌的所有用户: ${userList}");
    avatarInfo = await setAvatarApi.fetchAvatars();
    singlePlayer =
        await setAvatarApi.fetchSingleUsers(newAddUser.userId.toString());
    explosiveChestFun(newAddUser.userId.toString());
    print("单用户: ${singlePlayer}");
    // print("单用户: ${singlePlayer['id']}");
    print("头像信息: ${avatarInfo}");
    for (int i = 0; i < userList.length; i++) {
      print(userList[i].id);
      if (singlePlayer['id'].toString() == userList[i].id) {
        headId = userList[i].headgearId;
        // currentIsMale = userList[i].bodyName == 'Male' ? true : false;
        currentIsMale = userList[i].bodyId;
        currentNickName = userList[i].nickname;
      }
    }
    print("currentIsMale: ${currentIsMale}");
    // print("gameItemInfoBody: ${gameItemInfoBody}");
    // final bodyInfo = gameItemInfoBody.firstWhere((element) => element.id.toString() == currentIsMale);
    // print("哈哈哈哈哈哈哈哈: ${bodyInfo.id}");
    // print("bodyInfo: ${bodyInfo}");
    // currentBodyUrl = bodyInfo.icon;
    // print("bodyInfo: ${currentBodyUrl}");

    // currentNickName = singlePlayer['name'];
    print("当前头像ID: ${headId}");
    final avatar = avatarInfo.firstWhere((element) => element.id == headId);
    print("gfgfgfg: $avatar");
    currentUrl = avatar.url;
    print("头像: $avatarInfo");
    update();
  }
}
