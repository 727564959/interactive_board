import 'dart:convert';

import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../data/network/utils.dart';
import 'data/player.dart';
import 'data/player_api.dart';
import '../../data/network/show_repository.dart';
import '../../common.dart';

class ChoosePlayerLogic extends GetxController {
  final playerApi = PlayerApi();
  List<PlayerInfo> players = [];
  String get gameName => GameShowRepository().gameName!;
  final selectedPlayers = List<PlayerInfo?>.generate(4, (index) => null);
  bool get bSelectComplete => selectedPlayers.every((element) => element != null);
  MqttServerClient? _client;

  //3、4、5、6桌坐人，每桌上两人
  int getPosition(int index) {
    return (Global.team == 0 ? 1 : 5) + index;
  }

  @override
  void onInit() async {
    super.onInit();
    players = await playerApi.fetchPlayers();
    final client = getMQTTClient();
    _client = client;
    client.onConnected = () async {
      client.subscribe("event/game-round/position-update", MqttQos.atMostOnce);
      client.subscribe("event/game-round/position-clear", MqttQos.atLeastOnce);
      client.updates!.listen((c) {
        final recMess = c[0].payload as MqttPublishMessage;
        final topic = c[0].topic;
        final payload = jsonDecode(MqttPublishPayload.bytesToStringAsString(recMess.payload.message));
        final int team = payload['position'] < 5 ? 0 : 1;
        //如果队伍不同跳过
        if (team != Global.team) return;
        final index = (payload['position'] - 1) % 4;
        if (topic == "event/game-round/position-update") {
          final player = PlayerInfo.fromJson(payload);
          if (selectedPlayers[index]?.id == player.id) return;
          selectedPlayers[index] = player;
          update();
          update(["countdown"]);
        } else if (topic == "event/game-round/position-clear") {
          if (selectedPlayers[index] == null) return;
          selectedPlayers[index] = null;
          update();
          update(["countdown"]);
        }
      });
    };
    client.connect();
    update();
  }

  @override
  void onClose() {
    if (_client != null) {
      _client!.disconnect();
    }
    super.onClose();
  }

  List<PlayerInfo> get unselectedPlayers {
    final result = <PlayerInfo>[];
    for (final player in players) {
      if (!selectedPlayers.any((element) => player.username == element?.username)) {
        result.add(player);
      }
    }
    return result;
  }

  void choosePosition(index, username) {
    try {
      final player = players.firstWhere((element) => element.username == username);
      selectedPlayers[index] = player;
      update();
      update(["countdown"]);
      playerApi.updatePosition(username, getPosition(index));
    } on StateError {
      return;
    }
  }

  void removePlayer(index) {
    selectedPlayers[index] = null;
    playerApi.clearPosition(getPosition(index));
    update(["countdown"]);
  }
}
