import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../API/Class/Model_DataJson.dart';
import '../API/Function_Local_Json to Class.dart';

class API_Page extends StatefulWidget {
  const API_Page({super.key});

  @override
  State<API_Page> createState() => _API_PageState();
}

class _API_PageState extends State<API_Page> {
  List<Api> _DataFromWebAPI = List.empty(growable: true);

  Future GetDataFrom_API() async {
    String url = "https://covid19.ddc.moph.go.th/api/Cases/today-cases-all";
    final response = await http.get(Uri.parse(url));
    setState(() {
      _DataFromWebAPI = apiFromJson(response.body);
    });
  }

  Future LocalJsonData() async {
    var jsonText = await rootBundle.loadString('assets/Json/dataCovid.json');
    data = json.decode(jsonText);
    setState(() {
      ClassJSON.newDeath = data[0]['new_death'];
    });
  }

  @override
  void initState() {
    GetDataFrom_API();
    LocalJsonData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Build RUN');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("APP GetDataFrom_WebAPI & GetDataFrom_Local File Json"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            Text(
              '(FROM API)   Update date : ${(_DataFromWebAPI.isEmpty) ? "..." : _DataFromWebAPI[0].updateDate}',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            Text(
              '(FROM Json File)   New Death : ${ClassJSON.newDeath}',
              style: TextStyle(fontSize: 18),
            ),
          ]),
        ),
      ),
    );
  }
}
