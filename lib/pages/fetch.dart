// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'rough.dart' as rough;
// import 'home.dart' as home;

// class DataPage extends StatefulWidget {
//   @override
//   _DataPageState createState() => _DataPageState();
// }

// class _DataPageState extends State<DataPage> {
//   String link = 'https://internship-service.onrender.com/videos?page=';
//   int page = 0;
//   List<dynamic> data = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     final url = Uri.parse(link + page.toString());
//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         setState(() {
//           data = json.decode(response.body)['data']['posts'];
//         });
//         print("Success!");
//         // data is a dynamic list-
//         for (var x in ['creator', 'comment', 'reaction', 'submission']) {
//           // x is a map-
//           Map y = data[0][x];
//           // print('-' * 90);
//           // for (var z in y.keys) {
//           //   print(x);
//           //   print(y);
//           //   print(y[z]);
//           //   print(y[z].runtimeType);
//           //   print('-' * 90);
//           // }
//         }
//         page++;
//       } else {
//         print('Request failed with status: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Data Page'),
//       ),
//       body: Center(
//         child: TextButton(
//           child: Text('Lets G0!'),
//           onPressed: () => Navigator.push(
//             context,
//             MaterialPageRoute(
//               // builder: (context) => rough.TikTokPage(),
//               builder: (context) => home.ThumbnailsPage(),
//             ),
//           ),
//         ),
//       ),
//       // body: ListView.builder(
//       //   itemCount: data.length,
//       //   itemBuilder: (context, index) {
//       //     final item = data[index];
//       //     return ListTile(
//       //       title: Text(item['creator']['name']),
//       //       subtitle: Text(item['submission']['description']),
//       //     );
//       //   },
//       // ),
//     );
//   }
// }
