import 'dart:convert';

import 'package:get/get.dart';
import 'package:interactive_board/modules/set_avatar/data/new_add_user.dart';
import '../../common.dart';
import '../../data/model/show_state.dart';
import '../set_avatar/data/avatar_info.dart';
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

  String headId = "";
  bool currentIsMale = true;
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

  void clickBody(bool gender) {
    print("点击了身体");
    print("身体的id: $gender");
    currentIsMale = gender;
    update();
  }

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
      if(singlePlayer['id'].toString() == userList[i].id) {
        headId = userList[i].headgearId;
        currentIsMale = userList[i].bodyName == 'Male' ? true : false;
      }
    }
    currentNickName = singlePlayer['nickname'];
    final avatar = avatarInfo.firstWhere((element) => element.id == headId);
    currentUrl = avatar.url;
    update();
  }

  @override
  void onReady () async {
    print('onReady called');
    super.onReady();
    updateUserList(Get.arguments.showId);
    updatePlayer(Get.arguments.userId);
  }

  @override
  void onInit() async {
    super.onInit();
    // await Future.delayed(100.ms);
    print("需要展示的玩家ID: $newAddUser");
    print("需要展示的玩家ID: ${newAddUser.userId}");
    userList = await setAvatarApi.fetchUsers(newAddUser.showId??1);
    print("当桌的所有用户: ${userList}");
    avatarInfo = await setAvatarApi.fetchAvatars();
    singlePlayer = await setAvatarApi.fetchSingleUsers(newAddUser.userId.toString());
    print("单用户: ${singlePlayer}");
    // print("单用户: ${singlePlayer['id']}");
    print("头像信息: ${avatarInfo}");
    for (int i = 0; i < userList.length; i++) {
      print(userList[i].id);
      if(singlePlayer['id'].toString() == userList[i].id) {
        headId = userList[i].headgearId;
        currentIsMale = userList[i].bodyName == 'Male' ? true : false;
      }
    }
    currentNickName = singlePlayer['nickname'];
    print("当前头像ID: ${headId}");
    final avatar = avatarInfo.firstWhere((element) => element.id == headId);
    print("gfgfgfg: $avatar");
    currentUrl = avatar.url;
    print("头像: $avatarInfo");
    update();
  }
}
