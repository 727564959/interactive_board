import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../../../common.dart';
import '../data/casual_user.dart';
import '../data/show.dart';

class PlayerShowLogic extends GetxController {
  int? selectedTableId;
  String email = "";
  String phone = "";
  String firstName = "";
  String lastName = "";
  List<CasualUser> casualUser = [];
  // 传参信息
  ShowInfo get showInfo => Get.arguments;
  bool get bSelected => selectedTableId != null;
  final _dio = Dio();

  Future<List<CasualUser>> fetchCasualUser(int showId) async {
    print("是否进入了查询临时用户信息方法");
    print("$showId");
    final response = await _dio.get(
      "$baseApiUrl/shows/$showId/check-in/players",
      queryParameters: {"tableId": Global.tableId},
    );
    print("临时用户 $response");
    List casualUser = response.data;
    // List casualUser = [
    //   {
    //     "userId": 267,
    //     "nickname": "M_Zq",
    //     "bTemped": false,
    //     "bShowRegisterDialog": false
    //   },
    //   {
    //     "userId": 266,
    //     "nickname": "player8649",
    //     "bTemped": true,
    //     "bShowRegisterDialog": false
    //   },
    //   {
    //     "userId": 260,
    //     "nickname": "player1650",
    //     "bTemped": true,
    //     "bShowRegisterDialog": false
    //   }
    // ];
    return casualUser.map((user) => CasualUser.fromJson(user)).toList();
  }

  @override
  void onInit() async {
    super.onInit();
    casualUser = await fetchCasualUser(showInfo.showId);
    update();
  }
}