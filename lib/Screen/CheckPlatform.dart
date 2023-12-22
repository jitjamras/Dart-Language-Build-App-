import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Class/ClassPlatform_details.dart';
import '../MQTT/DataMQTT/DataMQTT.dart';
import '../MQTT/Global.dart';
import '../NavigatorPage.dart';

class CheckPlatform extends StatefulWidget {
  const CheckPlatform({super.key});

  @override
  State<CheckPlatform> createState() => _CheckPlatformState();
}

class _CheckPlatformState extends State<CheckPlatform> {
  @override
  void initState() {
    //! ทำการ Subscribe Topic ของ MQTT ครั้งแรกว่า มี Device ON : OFF อยู่ไหม
    mqttconnet.SubscribeMessage(DataMQTT.topic);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => MainPage()));
      },
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (PlatformDetails().isWeb) ...[
            const Center(
              child: Text(
                'Platform : Web',
                style: TextStyle(fontSize: 74, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )
          ] else if (PlatformDetails().isMobile) ...[
            const Center(
              child: Text(
                'Platform : Mobile',
                style: TextStyle(fontSize: 74, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )
          ] else if (PlatformDetails().isDesktop) ...[
            const Center(
              child: Text(
                'Platform : Desktop',
                style: TextStyle(fontSize: 74, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )
          ]
        ],
      )),
    );
  }
}
