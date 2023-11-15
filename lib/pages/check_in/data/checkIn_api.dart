import 'package:dio/dio.dart';

import '../../../common.dart';
import '../../../data/network/show_repository.dart';
import 'user_info.dart';

class CheckInApi {
  static CheckInApi? _instance;
  factory CheckInApi() => _instance ?? CheckInApi._internal();
  final dio = Dio();
  final showRepository = GameShowRepository();
  final baseUrl = "http://10.1.4.13:1337/api/game-show";
  CheckInApi._internal() {
    _instance = this;
  }

  Future<List<UserInfo>> fetchUserInfo() async {
    final response = await dio.get(
      "$baseUrl/show/users",
      queryParameters: {"showId": 1, "tableId": Global.tableId},
    );
    List userList = response.data['playerList'];
    return userList.map((user) => UserInfo.fromJson(user)).toList();
  }
}
