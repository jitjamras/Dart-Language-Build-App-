library global;

import 'dart:async';

import 'DataMQTT/DataMQTT.dart';
import 'mqttconnect.dart';


Map<dynamic, dynamic> SubscribeData = {};
String TopicSubscribe = '';

Mqttconnect mqttconnet = Mqttconnect();

List<ModelDevice_MQTT> ListStatus_Mode = List.empty(growable: true);

StreamController DataMQTT_ActiveDevice = StreamController.broadcast();
StreamController DataMQTT_modeAir = StreamController.broadcast();

List<bool> IsSelectAir = List.filled(4, false);
