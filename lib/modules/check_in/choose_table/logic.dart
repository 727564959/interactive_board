import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../../../common.dart';

class ChooseTableLogic extends GetxController {
  int? selectedTableId;
  bool get bSelected => selectedTableId != null;
  final _dio = Dio();

  void selectTable(int tableId) {
    selectedTableId = tableId;
    update();
  }

  // 查询并清理头套
  Future<Map> fetchHeadgearInfo(int userId) async {
    final response = await _dio.post("$baseApiUrl/players/$userId/headgear-acquisition-event", data: {});
    print("爆头套 $response");

    Map<String, dynamic> result = response.data;
    // Map<String, dynamic> result = {
    //             "itemInfo": {
    //                 "id": 22,
    //                 "name": "LowPoly_Dragn",
    //                 "type": "headgear",
    //                 "level": 1,
    //                 "icon": "/uploads/Highres_Screenshot00004_9049db84a3.png"
    //               }
    //               // "itemInfo": {
    //               //   "id": 20,
    //               //   "name": "Food_Burger",
    //               //   "type": "headgear",
    //               //   "level": 1,
    //               //   "icon": "/uploads/Highres_Screenshot00005_67afaf9dc4.png"
    //               // }
    //             };
    return result;
  }

  Future<int> loginInOrRegister({
    required String name,
    required String email,
    required String phone,
  }) async {
    late final int userId;
    try {
      final response1 = await _dio.get(
        "$baseApiUrl/players/query-id",
        queryParameters: {"email": email},
      );
      userId = response1.data['userId'];
    } on DioException {
      final response2 = await _dio.post(
        "$baseApiUrl/players/register",
        data: {"name": name, "email": email, "phone": phone},
      );
      userId = response2.data["userId"];
    }
    return userId;
  }

  Future<void> customerCheckIn({
    required int showId,
    required int userId,
  }) async {
    await _dio.post(
      "$baseApiUrl/shows/$showId/customer-checked",
      data: {
        "userId": userId,
        "showId": showId,
        "tableId": selectedTableId!,
      },
    );
  }
}
