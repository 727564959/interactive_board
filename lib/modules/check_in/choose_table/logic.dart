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
