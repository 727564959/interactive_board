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
  final baseUrl = "http://10.1.4.13:1337/api/game-show";
  CheckInApi._internal() {
    _instance = this;
  }

  Future<UserInfo> fetchUser(String id) async {
    final options = Options(headers: {
      "Authorization": "Bearer b81574102f5a012d9a235d3b1ce81c6000eb4e72636b696"
          "4029cd96795ea95989305748b8863f4f2d0726614e5f39bbdda702f81913fbe14238"
          "68569a0dfea202ac3fb459d50adb1ee7aa4e0e261d5a2f091af81b1cff0a96b2da7a7"
          "f725c26f13256977cacdb3297403ca5512afc17b128619c531eb5ac85a4588536bddd"
          "f38"
    });
    final response = await dio.get(
      "http://10.1.4.13:1337/api/users/$id",
      queryParameters: {"populate[headgear][populate][0]": "avatar"},
      options: options,
    );
    return UserInfo.fromStrapiJson(response.data);
  }

  Future<List<UserInfo>> fetchUsers() async {
    final response = await dio.get(
      "$baseUrl/show/users",
      queryParameters: {"showId": 1, "tableId": Global.tableId},
    );
    List userList = response.data['playerList'];
    return userList.map((user) => UserInfo.fromJson(user)).toList();
  }

  Future<List<AvatarInfo>> fetchAvatars() async {
    final response = await dio.get(
      "http://10.1.4.13:1337/api/headgears",
      queryParameters: {"populate[0]": "avatar"},
    );
    final result = <AvatarInfo>[];
    for (final item in response.data["data"]) {
      result.add(AvatarInfo.fromJson(item));
    }
    return result;
  }

  Future<void> updatePlayerInfo(String userId, String nickname, String headgearId, bool isMale) async {
    final options = Options(headers: {
      "Authorization": "Bearer b81574102f5a012d9a235d3b1ce81c6000eb4e72636b696"
          "4029cd96795ea95989305748b8863f4f2d0726614e5f39bbdda702f81913fbe14238"
          "68569a0dfea202ac3fb459d50adb1ee7aa4e0e261d5a2f091af81b1cff0a96b2da7a7"
          "f725c26f13256977cacdb3297403ca5512afc17b128619c531eb5ac85a4588536bddd"
          "f38"
    });
    final response = await dio.put(
      "http://10.1.4.13:1337/api/users/$userId",
      data: {
        "nickname": nickname,
        "headgear": headgearId,
        "isMale": isMale,
      },
      options: options,
    );
  }
}
