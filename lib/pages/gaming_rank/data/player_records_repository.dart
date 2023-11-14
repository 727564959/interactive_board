import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import '../../../data/network/utils.dart';
import 'player.dart';

class RecordsRepository {
  final baseUrl = "http://10.1.4.13:1337";
  MqttServerClient? _client;
  final _dio = Dio();
  void Function() onGameStart;
  Future<void> Function(List<dynamic>) onGamingUpdate;
  void Function() onGameOver;

  RecordsRepository({required this.onGameStart, required this.onGamingUpdate, required this.onGameOver}) {
    final client = getMQTTClient();
    _client = client;
    client.onConnected = () async {
      client.subscribe("event/game-round/gaming-update", MqttQos.atMostOnce);
      client.subscribe("event/game-round/game-start", MqttQos.atLeastOnce);
      client.subscribe("event/game-round/game-over", MqttQos.atLeastOnce);
      client.updates!.listen((c) {
        final recMess = c[0].payload as MqttPublishMessage;
        final topic = c[0].topic;
        if (topic == "event/game-round/game-start") {
          onGameStart();
        } else if (topic == "event/game-round/gaming-update") {
          final payload = jsonDecode(MqttPublishPayload.bytesToStringAsString(recMess.payload.message));
          onGamingUpdate(payload);
        } else if (topic == "event/game-round/game-over") {
          onGameOver();
        }
      });
    };
    client.connect();
  }

  Future<PlayerInfo> fetchPlayerInfo(String username, int position) async {
    final options = Options(headers: {
      "Authorization": "Bearer b81574102f5a012d9a235d3b1ce81c6000eb4e72636b696"
          "4029cd96795ea95989305748b8863f4f2d0726614e5f39bbdda702f81913fbe14238"
          "68569a0dfea202ac3fb459d50adb1ee7aa4e0e261d5a2f091af81b1cff0a96b2da7a7"
          "f725c26f13256977cacdb3297403ca5512afc17b128619c531eb5ac85a4588536bddd"
          "f38"
    });
    final response = await _dio.get(
      "$baseUrl/api/users",
      queryParameters: {
        "filters[username][\$eq]": username,
        "populate[0]": "avatar",
      },
      options: options,
    );
    final data = response.data[0];
    return PlayerInfo.fromJson({
      "id": data["id"],
      "username": data["username"],
      "nickname": data["nickname"],
      "avatarUrl": data["avatar"]["formats"]["thumbnail"]['url'],
      "position": position,
    });
  }

  void dispose() {
    if (_client != null) {
      _client!.disconnect();
    }
  }
}
