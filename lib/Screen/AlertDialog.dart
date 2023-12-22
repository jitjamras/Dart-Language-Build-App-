import 'dart:async';

import 'package:flutter/material.dart';

import '../Class/Class_AlertDialog.dart';

class AlertDialogScreen extends StatefulWidget {
  const AlertDialogScreen({super.key});

  @override
  State<AlertDialogScreen> createState() => __AlertDialogScreenState();
}

class __AlertDialogScreenState extends State<AlertDialogScreen> {
  StreamController<bool> Streamdata = StreamController.broadcast();
  Onpressed() {
    setState(() {
      Active[0].Active = !Active[0].Active;
      //! Update Data Realtime
      Streamdata.add(Active[0].Active);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'AlertDialog',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialogScreen(context),
                ),
                // showDialog(
                //     context: context,
                //     builder: (BuildContext context) => AlertDialogScreen(context)),
                child: Column(
                  children: [
                    const Text('Show Dialog'),
                  ],
                ),
              ),
              SizedBox(
                height: 300,
              ),
              Text(Active[0].Active.toString()),
            ],
          ),
        ),
      ),
    );
  }

  Widget AlertDialogScreen(BuildContext context) {
    return StreamBuilder<bool>(
        stream: Streamdata.stream,
        builder: (context, snapshot) {
          return AlertDialog(
            title: Icon(
              Icons.lightbulb,
              color: Active[0].Active ? Colors.amber : Colors.red,
            ),
            content: Text(
              'Do You Want To\n Turn On All Light ?',
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: Onpressed,
                      child: Text(
                          'Lets ${Active[0].Active ? 'Turn Off' : 'Turn On'} All Light'),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                          'Keep ${Active[0].Active ? 'Turn On' : 'Turn Off'}'),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
