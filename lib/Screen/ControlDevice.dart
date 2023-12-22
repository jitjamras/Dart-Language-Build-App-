import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_build_application/MQTT/DataMQTT/DataMQTT.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../Class/Class_Device.dart';
import '../MQTT/Global.dart';

class Control_MQTT extends StatefulWidget {
  const Control_MQTT({super.key});

  @override
  State<Control_MQTT> createState() => _Control_MQTTState();
}

class _Control_MQTTState extends State<Control_MQTT> {
  List<String> list = <String>['0', '50', '100', '150', '200', '254'];

  FunctionPublish_GET() {
    //! Sent get to MQTT follow pubtopic[index]
    for (var index = 0; index < ItemDevice.length; index++) {
      mqttconnet.publishMessage('get', ItemDevice[index].Pathpublish);
    }
  }

  FunctionCheckActive_(int index) {
    //! Function CheckActive and Publish "ON" || "OFF" To MQTT
    ItemDevice[index].active = !ItemDevice[index].active;
    mqttconnet.publishMessage(
        ItemDevice[index].active ? 'on' : 'off', ItemDevice[index].Pathpublish);
  }

  PublishDevice(int index, String Data, String PathPublish) {
    mqttconnet.publishMessage(Data, ItemDevice[index].Pathpublish);
  }

  @override
  initState() {
    FunctionPublish_GET();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("APP Subscribe MQTT & Publish MQTT"),
        centerTitle: true,
      ),
      body: Center(
          child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(30),
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              crossAxisCount: 2,
              children: List.generate(ItemDevice.length, (index) {
                return StreamBuilder(
                    stream: DataMQTT_ActiveDevice.stream,
                    builder: (context, snapshot) {
                      return InkWell(
                        onTap: () {
                          if (ItemDevice[index].name == "air_pur") {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  AlertDialogAC(context, index),
                            );
                          } else if (ItemDevice[index].name == "lsd_1g_1") {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  AlertDialogDim(context, index),
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blueGrey,
                              boxShadow: [BoxShadow(blurRadius: 3)]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: Text(
                                  'Control : ${ItemDevice[index].name}',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.lightbulb,
                                  color: ItemDevice[index].active
                                      ? Colors.amber
                                      : Colors.white,
                                ),
                              ),
                              ItemDevice[index].name == 'lsd_1g_1'
                                  ? Container()
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          foregroundColor:
                                              ItemDevice[index].active
                                                  ? Colors.white
                                                  : Colors.red,
                                          backgroundColor:
                                              ItemDevice[index].active
                                                  ? Colors.green
                                                  : Colors.white),
                                      onPressed: () {
                                        setState(() {
                                          FunctionCheckActive_(index);
                                        });
                                      },
                                      child: ItemDevice[index].active
                                          ? Text('ON')
                                          : Text('OFF')),
                              ItemDevice[index].name == 'lsd_1g_1'
                                  ? Container()
                                  : FlutterSwitch(
                                      onToggle: (value) {},
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      inactiveColor: Colors.grey.shade400,
                                      inactiveIcon: Text(
                                        'OFF',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      activeColor: Colors.green,
                                      activeTextFontWeight: FontWeight.w400,
                                      inactiveTextFontWeight: FontWeight.w400,
                                      activeIcon: Text(
                                        'ON',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      value: ItemDevice[index].active,
                                    )
                            ],
                          ),
                        ),
                      );
                    });
              }))),
    );
  }

  Widget AlertDialogAC(BuildContext context, int index) {
    return AlertDialog(
      title: Icon(
        Icons.light_mode_rounded,
        color: ItemDevice[index].active ? Colors.amber : Colors.grey,
      ),
      actions: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  ElevatedButton(
                    child: Text(DataMQTT.ModeAirPur[0]),
                    onPressed: () {
                      setState(() {
                        ItemDevice[index].mode = DataMQTT.ModeAirPur[0];
                        PublishDevice(index, ItemDevice[index].mode,
                            ItemDevice[index].Pathpublish);
                      });
                    },
                  ),
                  ElevatedButton(
                    child: Text(DataMQTT.ModeAirPur[1]),
                    onPressed: () {
                      setState(() {
                        ItemDevice[index].mode = DataMQTT.ModeAirPur[1];
                        PublishDevice(index, ItemDevice[index].mode,
                            ItemDevice[index].Pathpublish);
                      });
                    },
                  ),
                  ElevatedButton(
                    child: Text(DataMQTT.ModeAirPur[2]),
                    onPressed: () {
                      setState(() {
                        ItemDevice[index].mode = DataMQTT.ModeAirPur[2];
                        PublishDevice(index, ItemDevice[index].mode,
                            ItemDevice[index].Pathpublish);
                      });
                    },
                  ),
                  ElevatedButton(
                    child: Text(DataMQTT.ModeAirPur[3]),
                    onPressed: () {
                      setState(() {
                        ItemDevice[index].mode = DataMQTT.ModeAirPur[3];
                        PublishDevice(index, ItemDevice[index].mode,
                            ItemDevice[index].Pathpublish);
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget AlertDialogDim(BuildContext context, int index) {
    return AlertDialog(
      title: Icon(
        Icons.light_mode_rounded,
        color: ItemDevice[index].active ? Colors.amber : Colors.grey,
      ),
      actions: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                child: DropdownMenu(
              onSelected: (value) {
                if (value != 0) {
                  ItemDevice[index].active = true;
                } else {
                  ItemDevice[index].active = false;
                }
                PublishDevice(
                    index, value.toString(), ItemDevice[index].Pathpublish);
              },
              dropdownMenuEntries:
                  list.map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
