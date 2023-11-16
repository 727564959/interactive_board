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
  String get gameName => GameShowRepository().gameName!;
  List<UserInfo> userList = [];
  List<AvatarInfo> avatarInfo = [];
  bool isCheckIn = false;
  String currentNickName = "";
  String isAvatarType = "head";
  String headId = "";
  bool currentIsMale = true;
  MqttServerClient? _client;
  String currentUrl = "";

  String? selectedId;
  void clickItem(String id, String nickname) {
    print("点击了item");
    currentNickName = nickname;
    if (id == selectedId) {
      selectedId = null;
    } else {
      selectedId = id;
    }
    update();
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

  void birdShow() {
    var builder = MqttClientPayloadBuilder();
    _client?.publishMessage(
        "cmd/rain-forest/show-bird", MqttQos.atMostOnce, builder.payload!);
  }

  @override
  void onInit() async {
    super.onInit();
    userList = await checkInApi.fetchUsers();
    currentNickName = userList[0].nickname;
    avatarInfo = await checkInApi.fetchAvatars();
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
