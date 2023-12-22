import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Screen/APIScreen.dart';
import 'Screen/AlertDialog.dart';
import 'Screen/ControlDevice.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List DATAIcon = [
    Text(
      'MQTT',
      style: TextStyle(color: Colors.white),
    ),
    Text(
      'API',
      style: TextStyle(color: Colors.white),
    ),
    Text(
      'AlertDialog',
      style: TextStyle(color: Colors.white),
    )
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            "Main Application",
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              crossAxisCount: 2,
            ),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.red),
                    onPressed: () {
                      switch (index) {
                        case 1:
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const API_Page(),
                              ));
                        case 2:
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const AlertDialogScreen(),
                              ));
                        default:
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const Control_MQTT(),
                              ));
                      }
                    },
                    child: DATAIcon[index]),
              );
            },
          ),
        ));
  }
}
