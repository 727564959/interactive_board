import 'dart:convert';
import 'dart:ffi';

import 'package:get/get.dart';
import '../../common.dart';
import '../../data/model/show_state.dart';
import 'data/avatar_info.dart';
import 'data/casual_user.dart';
import 'data/checkin_api.dart';
import 'data/player_card.dart';
import 'data/team_info.dart';
import 'data/user_info.dart';

class CheckInLogic extends GetxController {
  final checkInApi = CheckInApi();
  // String get gameName => GameShowRepository().gameName!;
  List<UserInfo> userList = [];
  List<CasualUser> casualUser = [];
  // List<ResourceInfo> avatarInfo = [];
  ShowState get showState => Get.arguments;
  // Map<String,dynamic> singlePlayer = {};
  // 游戏show的开始时间
  // String showStartTime = "";
  DateTime get startTime =>
      (showState.details as ShowPreparingDetails).startTime;
  // 队伍icon合集
  List<TeamInfo> teamInfo = [];
  // 当前队伍能用的头像
  List<GameItemInfo> gameItemInfo = [];
  // 当前桌的消费者id
  int? consumerId;
  Map singlePlayer = {};
  String currentNickName = "";
  String headId = "";
  // bool currentIsMale = true;
  String currentIsMale = "";
  String currentUrl = "";
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

  String birthdayStr = "Please enter your birthday";

  String email = "";
  String phone = "";
  String firstName = "";
  String lastName = "";
  String countryName = "";

  int playerNum = 0;

  String teamName = "";
  int? teamInfoIndex;

  bool isClickCard = false;
  Map headgearObj = {};

  // final playerCardInfo = <PlayerCardInfo>[];
  List<PlayerCardInfo> playerCardInfo = [];

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

  void birdShow() {}

  void updateUserList(showId) async {
    print("身体的id: $showId");
    userList = await checkInApi.fetchUsers(showId);
    casualUser = await checkInApi.fetchCasualUser(showId);
    update();
  }

  void updatePlayer(String userId) async {
    print("身体的id: $userId");
    singlePlayer = await checkInApi.fetchSingleUsers(userId);
    // avatarInfo = await checkInApi.fetchAvatars();
    for (int i = 0; i < userList.length; i++) {
      print(userList[i].id);
      if (singlePlayer['id'].toString() == userList[i].id) {
        headId = userList[i].headgearId;
        currentIsMale = userList[i].bodyId;
      }
    }
    currentNickName = singlePlayer['name'];
    // final avatar = avatarInfo.firstWhere((element) => element.id == headId);
    // currentUrl = avatar.url;
    update();
  }

  // 选择生日确定
  void confirmBirthdayFun(var val) {
    print("选择生日 $val");
    birthdayStr = "${val?.year}" +
        "-" +
        (val?.month <= 9 ? "0" : "") +
        "${val?.month}" +
        "-" +
        (val?.day <= 9 ? "0" : "") +
        "${val?.day}";
    print("选择生日 $birthdayStr");
    update();
  }

  // 队伍icon选择，clickTeamName：当前点击icon名称；index：对应的teamInfo数组索引
  void selectTeamIcon(String clickTeamName, int index) {
    // 如果相等就置空，反之直接设置
    if(teamName == clickTeamName) {
      teamName = "";
      teamInfoIndex = null;
    }
    else {
      teamName = clickTeamName;
      teamInfoIndex = index;
    }
    update();
  }

  // 获取爆头套
  void getHeadgearFun(userId) async {
    print("opopopop ${userId}");
    headgearObj = await checkInApi.fetchHeadgearInfo(userId);
  }

  void updateHeadgearPageFun() {
    if(!isClickCard) {
      isClickCard = true;
      Future.delayed(1.2.seconds).then((value) async {
        // 刷新当前页面
        update(['treasureChest']);
      });
    }
    else {
      isClickCard = false;
      // 刷新当前页面
      update(['treasureChest']);
    }
  }

  // 爆宝箱头套方法
  void explosiveChestFun(userId) async {
    final gameItem = await checkInApi.fetchUserGameItems(userId);
    for(int i = 0; i < gameItem.length; i++) {
      if(gameItem[i].type == "headgear") {
        gameItemInfo.add(gameItem[i]);
        // print("爆出来的头像: ${gameItemInfo}");
      }
    }
    // gameItemInfo = await checkInApi.fetchUserGameItems(userId);
    print("爆出来的头像: ${gameItemInfo}");
    // 刷新当前页面
    update(['treasureChest']);
  }

  void clearRegisterFlag(userId) async {
    await checkInApi.clearRegisterFlag(userId);
    casualUser = await checkInApi.fetchCasualUser(showState.showId ?? 1);
    update(['nicknameArea']);
  }

  void testRefreshFun() async {
    print("刷新了吗");
    // 刷新当前页面
    update(['treasureChest']);
  }

  Future<void> getPlayerCardInfo(showId) async {
    casualUser = await checkInApi.fetchCasualUser(showId);
    userList = await checkInApi.fetchUsers(showId);
    playerCardInfo.clear();
    List<PlayerCardInfo> cards = [];
    for(int j = 0; j < casualUser.length; j++) {
      print("遍历开始 ${casualUser[j].userId}");
      final gameItem = await checkInApi.fetchUserGameItems(int.parse(casualUser[j].userId.toString()));
      final userData = userList.firstWhere((element) => element.id == casualUser[j].userId.toString());
      print("icon信息 ${gameItem}");
      print("用户 ${userData}");
      int avatarId = 1;
      String avatarIcon = '';
      String avatarName = '';
      int avatarLevel = 1;
      int bodyId = 10;
      String bodyIcon = '';
      String bodyName = '';
      int bodyLevel = 1;
      bool foundAvatar = false; // 布尔标志，用于跟踪是否找到符合条件的 avatar
      bool foundBody = false; // 布尔标志，用于跟踪是否找到符合条件的 body
      for(int m = 0; m < gameItem.length; m++){
        print("找相同 ${gameItem[m].id.toString() == userData.headgearId}");
        if(gameItem[m].id.toString() == userData.headgearId) {
          avatarId = gameItem[m].id;
          avatarIcon = gameItem[m].icon;
          avatarName = gameItem[m].name;
          avatarLevel = gameItem[m].level;
          foundAvatar = true; // 找到符合条件的 avatar
        }
        if(gameItem[m].id.toString() == userData.bodyId) {
          bodyId = gameItem[m].id;
          bodyIcon = gameItem[m].icon;
          bodyName = gameItem[m].name;
          bodyLevel = gameItem[m].level;
          foundBody = true; // 找到符合条件的 body
        }
        if (foundAvatar && foundBody) {
          break; // 当同时找到 avatar 和 body 时跳出内层循环
        }
      }
      if (foundAvatar && foundBody) {
        print("向玩家卡片加入数据");
        cards.add(PlayerCardInfo(
          userId: casualUser[j].userId,
          nickname: casualUser[j].nickname,
          bTemped: casualUser[j].bTemped,
          bShowRegisterDialog: casualUser[j].bShowRegisterDialog,
          avatarId: avatarId,
          avatarIcon: avatarIcon,
          avatarName: avatarName,
          avatarLevel: avatarLevel,
          bodyId: bodyId,
          bodyIcon: bodyIcon,
          bodyName: bodyName,
          bodyLevel: bodyLevel,
          isUserCard: true,
        ));
      }
    }

    print("cards ${cards}");
    if (cards.length <= 7) {
      playerCardInfo = List.generate(cards.length + 1, (index) {
        if (index < cards.length) {
          return cards[index];
        } else {
          return PlayerCardInfo(isUserCard: false);
        }
      },
      );
    } else {
      playerCardInfo = List.generate(cards.length, (index) => cards[index],);
    }
    // print("playerCardInfo ${playerCardInfo}");
    // print("playerCardInfo ${playerCardInfo[0].avatarId}");
    // print("playerCardInfo ${playerCardInfo[0].bodyId}");
    update(['playerCard']);
  }

  @override
  void onInit() async {
    super.onInit();
    try {
      teamInfo = await checkInApi.fetchSelectableTeamInfo();
      print("当前队伍能选择的队伍icon: ${teamInfo}");
    } catch (e) {
      print("查询队伍icon报错 $e");
    }

    print("show的状态数据: ${showState.status}");
    // casualUser = await checkInApi.fetchCasualUser(showState.showId ?? 1);
    // userList = await checkInApi.fetchUsers(showState.showId ?? 1);
    getPlayerCardInfo(showState.showId ?? 1);
    print("用户数据: $userList");
    // currentNickName = userList[userList.length - 1].nickname;
    // currentIsMale = userList[0].isMale;

    // currentIsMale = userList[0].bodyId;
    // headId = userList[0].headgearId;
    // avatarInfo = await checkInApi.fetchAvatars();

    if (showState.status == ShowStatus.showPreparing ||
        showState.status == ShowStatus.complete) {
      ShowPreparingDetails showPreparingDetails = showState.details;
      print("show开始时间: ${showPreparingDetails}");
      // showStartTime = showPreparingDetails.startTime.toString();
      // print("show开始时间: ${showStartTime}");
      List<CustomerItem> customerItem = showPreparingDetails.customers;
      for (int i = 0; i < customerItem.length; i++) {
        print(customerItem[i]);
        if (Global.tableId == customerItem[i].tableId) {
          consumerId = customerItem[i].userId;
        }
      }

      singlePlayer = await checkInApi.fetchSingleUsers(consumerId.toString());
      print("单用户: ${singlePlayer}");

      // // print("单用户: ${singlePlayer['id']}");
      // final avatar = avatarInfo.firstWhere((element) => element.id == headId);
      // print("gfgfgfg: $avatar");
      // currentUrl = avatar.url;
      // print("头像: $avatarInfo");
      // // checkInApi.updatePlayer(68, "abc",3,1);
    } else {}

    update();
  }
}
