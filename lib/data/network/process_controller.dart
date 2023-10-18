import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:interactive_board/app_routes.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'utils.dart';

class ProcessController {
  static ProcessController? _instance;
  factory ProcessController() => _instance ?? ProcessController._internal();
  final _dio = Dio();
  final baseUrl = "http://10.1.4.13:1337/api/game-show";
  MqttClient? _client;
  ProcessController._internal() {
    _instance = this;
    getMQTTClient().then((client) async {
      _client = client;
      client.subscribe("event/quiz/start", MqttQos.atMostOnce);
      await for (final msgQueue in client.updates!) {
        for (final item in msgQueue) {
          final recMess = item.payload as MqttPublishMessage;
          final topic = item.topic;
          if (topic == "event/quiz/start") {
            if (Get.currentRoute != '/quiz') {
              final payload = jsonDecode(MqttPublishPayload.bytesToStringAsString(recMess.payload.message));
              Get.toNamed(AppRoutes.quiz, arguments: payload);
            }
          }
        }
      }
    });
  }
}
