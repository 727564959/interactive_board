import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

const String mqttIpAddress = '10.1.4.13';

Future<MqttServerClient> getMQTTClient() async {
  final client = MqttServerClient(mqttIpAddress, '');
  client.logging(on: false);
  client.setProtocolV311();
  client.keepAlivePeriod = 20;
  final connMess = MqttConnectMessage().startClean().withWillQos(MqttQos.atLeastOnce);
  await client.connect();
  client.connectionMessage = connMess;
  return client;
}
