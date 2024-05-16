import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../../../common.dart';
import '../../mirra_look/data/player_card.dart';
import '../data/avatar_info.dart';
import '../data/casual_user.dart';
import '../data/player_page_api.dart';
import '../data/show.dart';
import '../data/skin_gender_option.dart';
import '../data/team_info.dart';
import '../data/user_info.dart';

class PlayerShowLogic extends GetxController {
  int? selectedTableId;
  String email = "";
  String phone = "";
  String firstName = "";
  String lastName = "";
  int? clickedCard;
  final playerPageApi = PlayerPageApi();
  List<UserInfo> userList = [];
  List<CasualUser> casualUser = [];
  List<PlayerCardInfo> playerCardInfo = [
    // PlayerCardInfo(
    //   userId: 291,
    //   nickname: "mzq",
    //   bTemped: true,
    //   bShowRegisterDialog: true,
    //   avatarId: 2,
    //   avatarIcon: "http://10.1.4.13:1337/uploads/TV_00b57f3012.png",
    //   avatarName: "TV",
    //   avatarLevel: 1,
    //   bodyId: 15,
    //   bodyIcon: "http://10.1.4.13:1337/uploads/TV_00b57f3012.png",
    //   bodyName: "Female_Suit_02",
    //   bodyLevel: 1,
    //   isUserCard: true,
    // ),
    // PlayerCardInfo(
    //   userId: 297,
    //   nickname: "testhahaha",
    //   bTemped: true,
    //   bShowRegisterDialog: true,
    //   avatarId: 20,
    //   avatarIcon: "http://10.1.4.13:1337/uploads/Highres_Screenshot00005_67afaf9dc4.png",
    //   avatarName: "Food_Burger",
    //   avatarLevel: 1,
    //   bodyId: 12,
    //   bodyIcon: "http://10.1.4.13:1337/uploads/4_5224a4e996.png",
    //   bodyName: "Male_Suit_01",
    //   bodyLevel: 1,
    //   isUserCard: true,
    // ),
    // PlayerCardInfo(isUserCard: false, nickname: "Player3",),
    // PlayerCardInfo(isUserCard: false, nickname: "Player3",),
    // PlayerCardInfo(isUserCard: false, nickname: "Player3",),
    // PlayerCardInfo(isUserCard: false, nickname: "Player3",),
    // PlayerCardInfo(isUserCard: false, nickname: "Player3",),
    // PlayerCardInfo(isUserCard: false, nickname: "Player3",)
  ];
  bool isCountdownStart = false;
  String teamlogo = "";
  List<GameItemInfo> gameItemInfo = [];
  String currentName = "";
  int? currentUserId;
  // 传参信息
  // ShowInfo get showInfo => Get.arguments;
  bool get bSelected => selectedTableId != null;
  SkinOption selectedSkin = SkinOption();
  GenderOption selectedGender = GenderOption();
  int get tableId => Get.arguments["tableId"];

  final _dio = Dio();

  void refreshPlayerLook(userId, avatarId) {
    print("刷新形象设计");
    getGameItems(userId, avatarId);
    update(['playerLookPage']);
  }

  void testFun() {
    print("测试刷新可以吗");
    // getCurrentTeam();
    getPlayerCardInfo(Get.arguments["showInfo"].showId);
    update(['playerSquadPage']);
  }

  Future<void> updateUserPreference(int userId, String nickname, int headgearId,
      String sex, String skinColor) async {
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

  Future<UserAvatar> fetchUserAvatar(userId) async {
    final response = await _dio.get("$baseApiUrl/players/$userId/avatar");
    print("用户信息 $response");
    final data = response.data;
    return UserAvatar.fromJson({...data});
  }

  Future<void> getPlayerCardInfo(showId) async {
    casualUser = await playerPageApi.fetchCasualUser(showId, tableId);
    userList = await playerPageApi.fetchUsers(showId, tableId);
    playerCardInfo.clear();
    List<PlayerCardInfo> cards = [];
    for (int j = 0; j < casualUser.length; j++) {
      print("遍历开始 ${casualUser[j].userId}");
      print("userList ${userList}");
      final gameItem =
          await playerPageApi.fetchUserGameItems(casualUser[j].userId);
      final userData =
          userList.firstWhere((element) => element.id == casualUser[j].userId);
      print("icon信息 ${gameItem}");
      print("用户 ${userData}");
      int avatarId = 1;
      String avatarIcon = '';
      String avatarName = '';
      int avatarLevel = 1;
      // int bodyId = 10;
      // String bodyIcon = '';
      // String bodyName = '';
      // int bodyLevel = 1;
      bool foundAvatar = false; // 布尔标志，用于跟踪是否找到符合条件的 avatar
      // bool foundBody = false; // 布尔标志，用于跟踪是否找到符合条件的 body
      for (int m = 0; m < gameItem.length; m++) {
        print("找相同 ${gameItem[m].id.toString() == userData.headgearId}");
        if (gameItem[m].id.toString() == userData.headgearId) {
          avatarId = gameItem[m].id;
          avatarIcon = gameItem[m].icon;
          avatarName = gameItem[m].name;
          avatarLevel = gameItem[m].level;
          foundAvatar = true; // 找到符合条件的 avatar
        }
        // if(gameItem[m].id.toString() == userData.bodyId) {
        //   bodyId = gameItem[m].id;
        //   bodyIcon = gameItem[m].icon;
        //   bodyName = gameItem[m].name;
        //   bodyLevel = gameItem[m].level;
        //   foundBody = true; // 找到符合条件的 body
        // }
        // if (foundAvatar && foundBody) {
        //   break; // 当同时找到 avatar 和 body 时跳出内层循环
        // }
        if (foundAvatar) {
          break; // 当同时找到 avatar 和 body 时跳出内层循环
        }
      }
      // if (foundAvatar && foundBody) {
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
            // bodyId: bodyId,
            // bodyIcon: bodyIcon,
            // bodyName: bodyName,
            // bodyLevel: bodyLevel,
            isUserCard: true,
            skinColor: userData.skinColor,
            sex: userData.sex));
      }
    }

    print("cards ${cards}");
    // if (cards.length <= 7) {
    //   playerCardInfo = List.generate(cards.length + 1, (index) {
    //     if (index < cards.length) {
    //       return cards[index];
    //     } else {
    //       return PlayerCardInfo(isUserCard: false, nickname: "");
    //     }
    //   },);
    // } else {
    //   playerCardInfo = List.generate(cards.length, (index) => cards[index],);
    // }

    if (cards.length < 8) {
      playerCardInfo = List.generate(8, (index) {
        if (index < cards.length) {
          return cards[index];
        } else {
          String temporaryStr = "Player" + (index + 1).toString();
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
    List<TeamInfo> teamList =
        await playerPageApi.fetchTeamInfo(Get.arguments["showInfo"].showId);
    for (int i = 0; i < teamList.length; i++) {
      print("yyyyy ${teamList[i]}");
      if (teamList[i].teamId == tableId) {
        print("hahahha ${teamList[i].iconPath}");
        teamlogo = teamList[i].iconPath;
      }
    }
  }

  Future<void> getGameItems(userId, avatarId) async {
    print("嘿哈嘿哈");
    gameItemInfo = await playerPageApi.fetchHeadgearInfo(userId);
    for (int i = 0; i < gameItemInfo.length; i++) {
      if (gameItemInfo[i].id == avatarId) {
        clickedCard = i;
      }
    }
  }

  @override
  void onInit() async {
    super.onInit();
    // casualUser = await fetchCasualUser(showInfo.showId);
    // 获取队伍
    getCurrentTeam();
    // 获取用户信息
    testFun();
    if (Get.arguments["isCountdownStart"] != null) {
      isCountdownStart = Get.arguments["isCountdownStart"];
    }
    update();
  }
}
