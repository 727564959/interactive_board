import 'package:get/get.dart';
import '../../data/model/player.dart';

class ChoosePlayerLogic extends GetxController {
  final players = [
    {"username": "Tom", "nickname": "Tom", "tableId": 5, "avatarUrl": "/uploads/_f56cfd3ac5.png", "joined": 2},
    {"username": "Olivia", "nickname": "Olivia", "tableId": 5, "avatarUrl": "/uploads/_d0aa881ef8.png", "joined": 3},
    {"username": "Paddy", "nickname": "Paddy", "tableId": 5, "avatarUrl": "/uploads/_be4f177098.png", "joined": 1},
    {"username": "Paddy", "nickname": "Paddy", "tableId": 5, "avatarUrl": "/uploads/_be4f177098.png", "joined": 0},
    {"username": "Paddy", "nickname": "Paddy", "tableId": 5, "avatarUrl": "/uploads/_be4f177098.png", "joined": 2},
    {"username": "antony", "nickname": "antony", "tableId": 5, "avatarUrl": "/uploads/_b27c81507c.png", "joined": 5}
  ].map((e) => PlayerInfo.fromJson(e)).toList();
}
