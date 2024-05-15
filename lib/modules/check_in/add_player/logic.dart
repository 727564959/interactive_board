import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../../../common.dart';
import '../data/avatar_info.dart';

class AddPlayerLogic extends GetxController {
  int? selectedTableId;
  String email = "";
  String phone = "";
  String firstName = "";
  String lastName = "";
  // String birthdayStr = "Please enter your birthday";
  DateTime birthdayStr = DateTime.now();
  bool get bSelected => selectedTableId != null;
  final _dio = Dio();

  // 选择生日确定
  // void confirmBirthdayFun(var val) {
  //   print("选择生日 $val");
  //   birthdayStr = "${val?.year}" +
  //       "-" +
  //       (val?.month <= 9 ? "0" : "") +
  //       "${val?.month}" +
  //       "-" +
  //       (val?.day <= 9 ? "0" : "") +
  //       "${val?.day}";
  //   print("选择生日 $birthdayStr");
  //   update();
  // }

  // 查重
  Future<Map> checkingPlayer(String email) async {
    print("通过邮箱进行玩家查重");
    print("object $email");
    try {
      final response = await _dio.get(
        "$baseApiUrl/players/query-id",
        queryParameters: {"email": email},
      );
      print("object $response");
      Map<String, dynamic> result = response.data;
      return result;
    } on DioException {
      Map<String, dynamic> result = {};
      return result;
    }
  }

  // 添加玩家时，点击了跳过
  Future<Map> addSkipPlayer() async {
    final response = await _dio.post("$baseApiUrl/players/register-temp", data: {});
    print(response.data);
    return response.data;
  }

  // 正常添加玩家
  Future<Map> addPlayerFun(int tableId,
      [String? email, String? phone, String? firstName, String? lastName, String? birthday]) async {
    String userName = (firstName != null && lastName != null)
        ? (firstName + " " + lastName)
        : ((firstName != null ? firstName : (lastName != null ? lastName : '')));
    final firstMap = tableId != null ? {"tableId": tableId} : {};
    final secondMap = userName != null ? {"name": userName} : {};
    final fourthlyMap = phone != null ? {"phone": phone} : {};
    final fifthMap = email != null ? {"email": email} : {};
    final sixthMap = birthday != null ? {"birthday": birthday} : {};
    final result = {
      ...firstMap,
      ...secondMap,
      // ...thirdlyMap,
      ...fourthlyMap,
      ...fifthMap,
      ...sixthMap,
    };
    print("哈哈哈哈哈 $result");
    final response = await _dio.post("$baseApiUrl/players/register", data: result);

    print(response.data);
    return response.data;
  }

  // 玩家加入show
  Future<void> addPlayerToShow(int showId, int tableId, int userId) async {
    final firstMap = tableId != null ? {"tableId": tableId} : {};
    final secondMap = userId != null ? {"userId": userId} : {};
    final result = {
      ...firstMap,
      ...secondMap,
    };
    await _dio.post("$baseApiUrl/shows/$showId/player-joined", data: result);
    print("哈哈哈哈哈 $result");
  }

  // 查询并清理头套
  Future<List<GameItemInfo>> fetchHeadgearInfo(userId) async {
    final response = await _dio.get(
      "$baseApiUrl/players/$userId/game-items",
    );
    final result = <GameItemInfo>[];
    for (final item in response.data) {
      result.add(GameItemInfo.fromJson(item['gameItem']));
    }
    return result;
  }
  // Future<Map> fetchHeadgearInfo(int userId) async {
  //   print("爆头套需要的userId $userId");
  //   final response = await _dio.post("$baseApiUrl/players/$userId/headgear-acquisition-event", data: {});
  //   print("爆头套 $response");
  //
  //   Map<String, dynamic> result = response.data;
  //   // Map<String, dynamic> result = {
  //   //   "itemInfo": {
  //   //     "id": 22,
  //   //     "name": "LowPoly_Dragn",
  //   //     "type": "headgear",
  //   //     "level": 1,
  //   //     "icon": "/uploads/Highres_Screenshot00004_9049db84a3.png"
  //   //   }
  //   //   // "itemInfo": {
  //   //   //   "id": 20,
  //   //   //   "name": "Food_Burger",
  //   //   //   "type": "headgear",
  //   //   //   "level": 1,
  //   //   //   "icon": "/uploads/Highres_Screenshot00005_67afaf9dc4.png"
  //   //   // }
  //   // };
  //   return result;
  // }
}