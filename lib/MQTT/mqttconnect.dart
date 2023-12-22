import 'dart:async';
import 'dart:convert';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import '../Class/Class_Device.dart';
import 'DataMQTT/DataMQTT.dart';
import 'Global.dart';

class Mqttconnect {
  late MqttServerClient client = MqttServerClient.withPort(
      DataMQTT.broker, DataMQTT.clientId, DataMQTT.port);
  Future<dynamic> connect() async {
    client.logging(on: false); //ปิด Log
    client.setProtocolV311();
    client.onConnected = (() => print('MQTT_LOGS:: Connected'));
    client.onSubscribed =
        ((topic) => print('MQTT_LOGS:: Subscribed topic: ${DataMQTT.topic}'));
    client.onDisconnected =
        (() => print('MQTT_LOGS:: Failed to subscribe ${DataMQTT.topic}'));
    client.onUnsubscribed =
        ((topic) => print('MQTT_LOGS:: Unsubscribed topic: ${DataMQTT.topic}'));
    client.onSubscribeFail =
        ((topic) => print('MQTT_LOGS:: Failed to subscribe ${DataMQTT.topic}'));
    client.pongCallback =
        (() => print('MQTT_LOGS:: Ping response client callback invoked'));
    client.keepAlivePeriod = 60;
    client.autoReconnect = true;
    try {
      await client.connect(DataMQTT.usernameMQTT, DataMQTT.passwordMQTT);
    } catch (e) {
      print('Error is : $e');
      client.disconnect();
    }
    final connMessage = MqttConnectMessage()
        .withWillTopic('willtopic')
        .withWillMessage('Will message')
        .startClean()
        .authenticateAs(DataMQTT.usernameMQTT, DataMQTT.passwordMQTT)
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;

    //Check Connect Mqtt
    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      print('NOW Client Connected');
    } else {
      print('NOW Client Disconnected IS : ${client.connectionStatus}');
      client.disconnect();
    }

    return client;
  }

  SubscribeMessage(
    String topic,
  ) {
    //เลือก topic ที่จะทำการ follow
    client.subscribe(topic, MqttQos.atMostOnce); //ทำการติดตาม หัวข้อ topic นั้น
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt = MqttPublishPayload.bytesToStringAsString(
          recMess.payload.message); //แปลงข้อมูลที่ส่งมาจาก bytestoString

      SubscribeData = jsonDecode(pt);
      TopicSubscribe = c[0].topic;
      // print(SubscribeData['status']);
      // print(TopicSubscribe);
      FunctionCheckStatus_(ItemDevice);
    });
  }

  publishMessage(String message, String pubtopic) {
    //ทำการส่ง publishMessage
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      client.publishMessage(pubtopic, MqttQos.atMostOnce, builder.payload!);
      print('${utf8.decode(builder.payload!)} $pubtopic');
    }
  }

  FunctionCheckStatus_(List<ModelDevice> ItemDevice) {
    for (var index = 0; index < ItemDevice.length; index++) {
      if (TopicSubscribe == ItemDevice[index].Pathsubscribe) {
        //? First Time | Add to List 0 - ItemDevice.length
        if (ListStatus_Mode.length < ItemDevice.length) {
          ListStatus_Mode.add(ModelDevice_MQTT(
              TopicSub: TopicSubscribe, Status: SubscribeData));
          if (ListStatus_Mode[index].Status['status'] == 'on') {
            ItemDevice[index].active = true;
          } else {
            ItemDevice[index].active = false;
          }
          print('TOPICSUB FT: ${ListStatus_Mode[index].TopicSub}');
          print('STATUS FT: ${ListStatus_Mode[index].Status}');
        } else if (ListStatus_Mode.length == ItemDevice.length) {
          ListStatus_Mode[index].TopicSub = TopicSubscribe;
          ListStatus_Mode[index].Status = SubscribeData;
          if (ListStatus_Mode[index].Status['status'] == 'on') {
            ItemDevice[index].active = true;
          } else {
            ItemDevice[index].active = false;
          }
          print('TOPICSUB NEW: $index  || ${ListStatus_Mode[index].TopicSub}');
          print('STATUS NEW: $index  || ${ListStatus_Mode[index].Status}');
        }
        DataMQTT_ActiveDevice.add(ItemDevice[index].active);
      }
    }
  }
}
