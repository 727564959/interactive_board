import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';
import 'package:widgets_to_image/widgets_to_image.dart';


import '../../../common.dart';
import '../check_in/data/avatar_info.dart';

class TermsOfUseLogic extends GetxController {
  final _dio = Dio();
  bool isSelectedOne = false;
  bool isSelectedTwo = false;
  bool isDisable = true;

  SignatureController signatureController = SignatureController();
  WidgetsToImageController widgetsToImageController = WidgetsToImageController();
  bool get isSignatureNotEmpty => signatureController.isNotEmpty;

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

  // 查询单个玩家
  Future<Map> fetchSingleUsers(id) async {
    print("是否进入了查询单个玩家方法");
    final response = await _dio.get("$baseApiUrl/players/$id/base");

    Map<String, dynamic> result = response.data;
    return result;
  }

  // 查重
  Future<Map> checkingPlayer(String email) async {
    print("通过邮箱进行玩家查重");
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

  void refreshFun() {
    update(['TermsOfUsePage']);
  }

  void clearSignatureBar() {
    signatureController.clear();
  }

  Future<void> uploadSignature(String name) async {
    final date = DateFormat("yyyyMMdd").format(DateTime.now());
    final dio = Dio();
    final captureFuture = widgetsToImageController.capture(pixelRatio: 0.5);
    final presignedFuture = dio.get(
      "https://inb27b1nma.execute-api.us-east-1.amazonaws.com/put_signature_pic_to_s3",
      queryParameters: {"object_name": "$date/$name-${_generateRandomString(6)}"},
    );
    final [data, response as Response] = await Future.wait([captureFuture, presignedFuture]);
    if (data == null) throw Exception("Signature data is Null!");
    String presignedUrl = jsonDecode(response.data)["presigned_url"];
    await dio.put(
      presignedUrl,
      data: data,
      options: Options(contentType: "image/png"),
    );
  }

  String _generateRandomString(int length) {
    const charset = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    String result = '';

    for (int i = 0; i < length; i++) {
      int randomIndex = random.nextInt(charset.length);
      result += charset[randomIndex];
    }

    return result;
  }

  @override
  void onInit() async {
    super.onInit();
    update();
  }
}