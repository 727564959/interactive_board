import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

Future<MqttServerClient?> getMQTTClient(String ipAddress, List<String> topics) async {
  if (topics.isEmpty) return null;
  final client = MqttServerClient(ipAddress, '');
  client.logging(on: false);
  client.setProtocolV311();
  client.keepAlivePeriod = 20;
  final connMess = MqttConnectMessage().startClean().withWillQos(MqttQos.atLeastOnce);
  await client.connect();
  client.connectionMessage = connMess;
  for (var topic in topics) {
    client.subscribe(topic, MqttQos.atMostOnce);
  }
  return client;
}
