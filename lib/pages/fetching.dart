import 'package:http/http.dart' as http;
import 'dart:convert';

String link = 'https://internship-service.onrender.com/videos?page=';

Future<List> fetchData(int page) async {
  List<dynamic> data = [];
  final url = Uri.parse(link + page.toString());
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      data = json.decode(response.body)['data']['posts'];
      print("Success!");
      page++;
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
  return data;
}

void main() async {
  print('Hello, World!');
  print(await fetchHome(0));
  // print("Enter your page?");
  // int page = int.parse(stdin.readLineSync().toString());
  // await Future.delayed(Duration(seconds: 60));
  // resolveData(page, i) async {
  // List result = await fetchData(page);
  // int count = result.length;
  // for (var x in ['creator', 'comment', 'reaction', 'submission']) {
  //   // x is a map-
  //   var y = result[i][x];
  //   print('-' * 90);
  //   print((i + 1).toString() + ' User Data ' + 'Type : ' + x);
  //   for (var z in y.keys) {
  //     // print('Type : ' + x);
  //     print(' : ' + z + '[' + y[z].toString() + ']');
  //     // print('Data : ');
  //     // print(y[z].runtimeType);
  //     // print('-' * 90);
  //   }
  // }
// //----------------------------------------
//     if (['name', 'id', 'handle', 'pic'].contains(ask)) {
//       var requiredData = result[i]['creator'][ask];
//       return requiredData;
//     } else if ([
//       'title',
//       'description',
//       'mediaUrl',
//       'thumbnail',
//       'hyperlink',
//       'placeholderUrl'
//     ].contains(ask)) {
//       var requiredData = result[i]['submission'][ask];
//       return requiredData;
//     }
  // List data = [];

  // print(await resolveData(5, 0) + await resolveData(5, 0));
}

Future<List<dynamic>> fetchHome(page) async {
  List result = await fetchData(page);
  List dataThumbnail = [];
  List dataName = [];
  List dataPic = [];
  List data = [];
  for (var i = 0; i < 10; i++) {
    dataThumbnail.add(result[i]['submission']['thumbnail']);
    dataName.add(result[i]['creator']['name']);
    dataPic.add(result[i]['creator']['pic']);
  }
  data.add(dataThumbnail);
  data.add(dataName);
  data.add(dataPic);
  return data;
}
