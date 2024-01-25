import 'dart:convert';

import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import '../../data/network/show_repository.dart';
import '../../common.dart';
import '../../data/network/utils.dart';
import 'data/avatar_info.dart';
import 'data/checkin_api.dart';
import 'data/user_info.dart';

class CheckInLogic extends GetxController {
  final checkInApi = CheckInApi();
  // String get gameName => GameShowRepository().gameName!;
  List<UserInfo> userList = [];
  List<AvatarInfo> avatarInfo = [];
  bool isCheckIn = false;
  String currentNickName = "";
  String isAvatarType = "head";
  String headId = "";
  bool currentIsMale = true;
  MqttServerClient? _client;
  String currentUrl = "";
  bool checkinBtnIsDown = false;
  bool isUpdateName = false;

  String? selectedId;

  void clickItem(String id, String nickname, String avatarUrl, bool isMale) async {
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

    currentIsMale = isMale;
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
      username: userList[index].username,
      isMale: currentIsMale,
      headgearId: headId,
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
    var builder = MqttClientPayloadBuilder();
    _client?.publishMessage("cmd/rain-forest/show-bird", MqttQos.atMostOnce, builder.payload!);
  }

  @override
  void onInit() async {
    super.onInit();
    userList = await checkInApi.fetchUsers();
    currentNickName = userList[0].nickname;
    currentIsMale = userList[0].isMale;
    headId = userList[0].headgearId;
    avatarInfo = await checkInApi.fetchAvatars();
    final avatar = avatarInfo.firstWhere((element) => element.id == headId);
    currentUrl = avatar.transparentBackgroundUrl;
    print("头像: $avatarInfo");
    final client = getMQTTClient();
    _client = client;
    // client.onConnected = () async {
    //   client.updates!.listen((c) {
    //     final recMess = c[0].payload as MqttPublishMessage;
    //     final topic = c[0].topic;
    //     final payload = jsonDecode(MqttPublishPayload.bytesToStringAsString(recMess.payload.message));
    //   });
    // };
    client.connect();
  }

  @override
  void onClose() {
    _client?.disconnect();
    super.onClose();
  }
}
