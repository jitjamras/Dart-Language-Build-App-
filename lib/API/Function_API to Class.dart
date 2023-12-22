// import 'package:http/http.dart' as http;

// import 'Class/Model_DataJson.dart';

// List<Api> _DataFromAPI = List.empty(growable: true);

// Future GetDataFrom_API(List<Api> DataFromAPI, Function() setState) async {
//   String url = "https://covid19.ddc.moph.go.th/api/Cases/today-cases-all";
//   final response = await http.get(Uri.parse(url));
//   print(response.body);
//       setState(() {
//       DataFromAPI = apiFromJson(response.body);
//     });
// }
