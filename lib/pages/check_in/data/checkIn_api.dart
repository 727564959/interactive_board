import 'package:dio/dio.dart';
import 'package:interactive_board/pages/check_in/data/avatar_info.dart';

import '../../../common.dart';
import '../../../data/network/show_repository.dart';
import 'user_info.dart';

class CheckInApi {
  static CheckInApi? _instance;
  factory CheckInApi() => _instance ?? CheckInApi._internal();
  final dio = Dio();
  final showRepository = GameShowRepository();
  // final baseUrl = "http://10.1.4.13:1337/api/game-show";
  final baseUrl = "http://10.1.4.16:1337/api";
  CheckInApi._internal() {
    _instance = this;
  }

  Future<UserInfo> fetchUser(String id) async {
    final response = await dio.get(
      "http://10.1.4.16:1337/api/users/$id",
      queryParameters: {"populate[headgear][populate][0]": "avatar"},

    );
    return UserInfo.fromStrapiJson(response.data);
  }

  Future<List<UserInfo>> fetchUsers() async {
    print("是否进入了查询用户信息方法");
    print("444444 $showRepository");
    print("hhhhhh ${showRepository.showId}");
    final response = await dio.get(
      "$baseUrl/shows/3/players",
      queryParameters: {"tableId": Global.tableId},
    );
    // List userList = response.data['playerList'];
    print("测试接口 $response");
    List userList = response.data;
    return userList.map((user) => UserInfo.fromJson(user)).toList();
  }

  Future<List<ResourceInfo>> fetchBodies() async {
    final response = await dio.get(
      "http://10.1.4.16:1337/api/bodies",
      queryParameters: {
        "populate[0]": "image",
      },

    );
    print(response.data);
    final result = <ResourceInfo>[];
    for (final item in response.data["data"]) {
      result.add(ResourceInfo.fromJson(item));
    }
    return result;
  }

  Future<List<ResourceInfo>> fetchAvatars() async {
    final response = await dio.get(
      "http://10.1.4.16:1337/api/headgears",
      queryParameters: {
        "populate[0]": "image",
      },
    );
    print(response.data);
    final result = <ResourceInfo>[];
    for (final item in response.data["data"]) {
      result.add(ResourceInfo.fromJson(item));
    }
    return result;
  }

  Future<void> updatePlayerInfo(
      String userId, String nickname, String headgearId, bool isMale) async {
    print("12345上山打老虎");
    final response = await dio.put(
      "http://10.1.4.16:1337/api/users/$userId",
      data: {
        "nickname": nickname,
        "headgear": headgearId,
        "isMale": isMale,
      },
    );
  }
}
