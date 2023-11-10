import 'dart:convert';
import 'package:get/get.dart';
import 'package:interactive_board/app_routes.dart';
import 'package:interactive_board/common.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'show_repository.dart';
import 'utils.dart';

class ProcessController {
  static ProcessController? _instance;
  factory ProcessController() => _instance ?? ProcessController._internal();
  final baseUrl = "http://10.1.4.13:1337/api/game-show";
  final showRepository = GameShowRepository();
  MqttClient? _client;
  ProcessController._internal() {
    _instance = this;

    final client = getMQTTClient();
    _client = client;
    client.onConnected = () async {
      client.subscribe("event/quiz/start", MqttQos.atMostOnce);
      client.subscribe("event/show/start", MqttQos.atMostOnce);
      client.subscribe("event/show/stop", MqttQos.atMostOnce);

      // client.subscribe("event/game-round/game-over", MqttQos.atMostOnce);
      client.updates!.listen((c) async {
        if (!Global.bTableIdExist) return;
        final recMess = c[0].payload as MqttPublishMessage;
        final topic = c[0].topic;
        if (topic == "event/quiz/start") {
          if (Get.currentRoute != AppRoutes.quiz) {
            final payload = jsonDecode(MqttPublishPayload.bytesToStringAsString(recMess.payload.message));
            Get.offAllNamed(AppRoutes.quiz, arguments: payload);
          }
        } else {
          await showRepository.updateShowState();
          if (topic == "event/show/start") {
            if (showRepository.showId == null) return;
            Get.offAllNamed(AppRoutes.choosePlayer);
          } else if (topic == "event/show/stop") {
            Get.offAllNamed(AppRoutes.main);
          }
          // else if (topic == "event/game-round/game-over") {
          //   if (showRepository.showId == null) return;
          //   Get.offAllNamed(AppRoutes.choosePlayer);
          // }
        }
      });
    };
    client.connect();
  }
}
