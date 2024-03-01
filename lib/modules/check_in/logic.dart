import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'binding.dart';
import 'verification_code/view.dart';
import 'data/booking.dart';
import '../../common.dart';

class CheckInLogic extends GetxController {
  int? selectedTableId;
  bool get bSelected => selectedTableId != null;
  final _dio = Dio();
  @override
  void onInit() async {
    super.onInit();
  }

  void selectTable(int tableId) {
    selectedTableId = tableId;
    update();
  }

  Future<VerifyInfo> verifyValidity(int transactionId, String email) async {
    final response = await _dio.get(
      "$baseApiUrl/show/booking-verify",
      queryParameters: {
        "transactionId": transactionId,
        "email": email,
      },
    );
    return VerifyInfo.fromJson(response.data);
  }

  Future<void> customerCheckIn({
    required int showId,
    required int transactionId,
    required int bookingId,
    required String name,
    required String email,
    required String phone,
  }) async {
    await _dio.post(
      "$baseApiUrl/shows/$showId/customer-checked",
      data: {
        "transactionId": transactionId,
        "bookingId": bookingId,
        "email": email,
        "name": name,
        "phone": phone,
        "tableId": selectedTableId!,
      },
    );
  }

  Future<List<int>> fetchFullTables(int showId) async {
    final response = await _dio.get("$baseApiUrl/game-shows/$showId");
    final result = <int>[];
    for (final item in response.data['data']['attributes']['associatedUsers']) {
      result.add(item['tableId']);
    }
    return result;
  }

  void backToVerificationPage() {
    Get.offAll(
      () => VerificationPage(),
      bindings: [CheckInBinding()],
      transition: Transition.rightToLeft,
    );
  }
}
