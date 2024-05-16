import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common.dart';
import '../../../data/model/show_state.dart';
import '../../mirra_look/data/player_card.dart';
import '../data/avatar_info.dart';
import '../data/casual_user.dart';
import '../data/skin_gender_option.dart';
import '../data/team_list.dart';
import '../data/user_info.dart';

class PlayerShowPageLogic extends GetxController {
  final _dio = Dio();

  List<UserInfo> userList = [];
  List<CasualUser> casualUser = [];
  List<PlayerCardInfo> playerCardInfo = [];
  String teamlogo = "";
  List<GameItemInfo> gameItemInfo = [];
  int? clickedCard;
  SkinOption selectedSkin = SkinOption();
  GenderOption selectedGender = GenderOption();

  void refreshFun() {
    print("测试刷新可以吗");
    getPlayerCardInfo(Get.arguments["showState"].showId);
    update(['playerShowPage']);
  }

  Future<void> updateUserPreference(int userId, String nickname, int headgearId, String sex, String skinColor) async {
    final response = await _dio.post(
      "$baseApiUrl/players/$userId/update-user-preference",
      data: {
        "nickname": nickname,
        "headgearId": headgearId,
        "sex": sex,
        "skinColor": skinColor,
      },
    );
  }

  Future<List<CasualUser>> fetchCasualUser(int showId) async {
    print("是否进入了查询临时用户信息方法");
    final response = await _dio.get(
      "$baseApiUrl/shows/$showId/check-in/players",
      queryParameters: {"tableId": Global.tableId},
    );
    print("临时用户 $response");
    List casualUser = response.data;
    return casualUser.map((user) => CasualUser.fromJson(user)).toList();
  }

  Future<List<UserInfo>> fetchUsers(int showId) async {
    print("是否进入了查询用户信息方法");
    final response = await _dio.get(
      "$baseApiUrl/shows/$showId/players",
      queryParameters: {"tableId": Global.tableId},
    );
    print("测试接口 $response");
    List userList = response.data;
    return userList.map((user) => UserInfo.fromJson(user)).toList();
  }

  Future<List<GameItemInfo>> fetchUserGameItems(userId) async {
    final response = await _dio.get(
      "$baseApiUrl/players/$userId/game-items",
    );
    final result = <GameItemInfo>[];
    for (final item in response.data) {
      result.add(GameItemInfo.fromJson(item['gameItem']));
    }
    return result;
  }

  // 查询队伍信息
  Future<List<TeamList>> fetchTeamInfo(int showId) async {
    print("是否进入了查询队伍信息方法");
    final response = await _dio.get(
        "$baseApiUrl/shows/$showId/team-info"
    );
    print("所有队伍信息 $response");
    List teamList = response.data;
    return teamList.map((team) => TeamList.fromJson(team)).toList();
  }

  // Future<List<GameItemInfo>> fetchHeadgearInfo(userId) async {
  //   final response = await _dio.get(
  //     "$baseApiUrl/players/$userId/game-items",
  //   );
  //   final result = <GameItemInfo>[];
  //   for (final item in response.data) {
  //     result.add(GameItemInfo.fromJson(item['gameItem']));
  //   }
  //   return result;
  // }

  Future<UserAvatar> fetchUserAvatar(userId) async {
    final response = await _dio.get(
        "$baseApiUrl/players/$userId/avatar"
    );
    print("用户信息 $response");
    final data = response.data;
    return UserAvatar.fromJson({
      ...data
    });
  }

  Future<void> getPlayerCardInfo(showId) async {
    casualUser = await fetchCasualUser(showId);
    userList = await fetchUsers(showId);
    playerCardInfo.clear();
    List<PlayerCardInfo> cards = [];
    for(int j = 0; j < casualUser.length; j++) {
      print("遍历开始 ${casualUser[j].userId}");
      print("userList ${userList}");
      final gameItem = await fetchUserGameItems(casualUser[j].userId);
      final userData = userList.firstWhere((element) => element.id == casualUser[j].userId);
      print("icon信息 ${gameItem}");
      print("用户 ${userData}");
      int avatarId = 1;
      String avatarIcon = '';
      String avatarName = '';
      int avatarLevel = 1;
      bool foundAvatar = false; // 布尔标志，用于跟踪是否找到符合条件的 avatar
      for(int m = 0; m < gameItem.length; m++){
        print("找相同 ${gameItem[m].id.toString() == userData.headgearId}");
        if(gameItem[m].id.toString() == userData.headgearId) {
          avatarId = gameItem[m].id;
          avatarIcon = gameItem[m].icon;
          avatarName = gameItem[m].name;
          avatarLevel = gameItem[m].level;
          foundAvatar = true; // 找到符合条件的 avatar
        }
        if (foundAvatar) {
          break; // 当同时找到 avatar 和 body 时跳出内层循环
        }
      }
      if (foundAvatar) {
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
            isUserCard: true,
            skinColor: userData.skinColor,
            sex: userData.sex
        ));
      }
    }

    print("cards ${cards}");
    if (cards.length < 8) {
      playerCardInfo = List.generate(8, (index) {
        if (index < cards.length) {
          return cards[index];
        } else {
          String temporaryStr = "Player" + index.toString();
          return PlayerCardInfo(isUserCard: false, nickname: temporaryStr);
        }
      });
    } else {
      playerCardInfo = List.generate(cards.length, (index) => cards[index]);
      // playerCardInfo.addAll(List.generate(8 - cards.length, (index) => PlayerCardInfo(isUserCard: false, nickname: "")));
    }
    print("playerCardInfo ${playerCardInfo}");
    update(['playerSquadPage']);
  }

  Future<void> getCurrentTeam() async {
    List<TeamList> teamList = await fetchTeamInfo(Get.arguments["showState"].showId);
    for(int i = 0; i < teamList.length; i++) {
      print("yyyyy ${teamList[i]}");
      if(teamList[i].teamId == Global.tableId) {
        print("hahahha ${teamList[i].iconPath}");
        teamlogo = teamList[i].iconPath;
      }
    }
  }

  Future<void> getGameItems(userId, avatarId) async {
    gameItemInfo = await fetchUserGameItems(userId);
    for(int i = 0; i < gameItemInfo.length; i++) {
      if(gameItemInfo[i].id == avatarId) {
        clickedCard = i;
      }
    }
  }

  @override
  void onInit() async {
    super.onInit();
    print("刷新了吗");
    // print("object ${Get.arguments["playerCardInfo"] == null}");
    // print("object ${Get.arguments["playerCardInfo"]}");
    // if(Get.arguments["playerCardInfo"] == null || Get.arguments["teamlogo"] == null) {
    //   print("是否为空");
    //   getCurrentTeam();
    //   refreshFun();
    //   Get.arguments["playerCardInfo"] = playerCardInfo;
    //   Get.arguments["teamlogo"] = teamlogo;
    // }
    // 获取队伍
    getCurrentTeam();
    // 获取用户信息
    getPlayerCardInfo(Get.arguments["showState"].showId);
    Future.delayed(0.5.seconds).then((value) async {
      print("延迟刷新 $playerCardInfo");
      update(['playerShowPage']);
    },);
  }
}