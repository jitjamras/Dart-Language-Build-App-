import 'dart:convert';

import 'package:flutter/services.dart';

import 'Class/Model_DataJson.dart';


late List data;
Api ClassJSON = Api();

Future LocalJsonData() async {
  var jsonText = await rootBundle.loadString('assets/Json/dataCovid.json');
  data = json.decode(jsonText);
  ClassJSON.newDeath = data[0]['new_death'];
}
