import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'fetching.dart';
import 'rough.dart' as rough;

class ThumbnailPage extends StatefulWidget {
  const ThumbnailPage({Key? key}) : super(key: key);

  @override
  _ThumbnailPageState createState() => _ThumbnailPageState();
}

// class _ThumbnailPageState extends State<ThumbnailPage> {
//   List<dynamic> videos = [];
//   int page = 1;

//   Future<void> fetchVideos(page) async {
//     videos = await fetchHome(page);
//     // final response = await http.get(Uri.parse('API_URL?page=$page'));
//     // if (response.statusCode == 200) {
//     //   setState(() {
//     //     videos.addAll(json.decode(response.body));
//     //     page++;
//     //   });
//     // }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchVideos(0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: (videos[0].length + 1),
//         itemBuilder: (context, index) {
//           if (index < videos[0].length) {
//             // final video = videos[index];
//             return ListTile(
//               leading: CircleAvatar(
//                 backgroundImage: NetworkImage(videos[0][index]),
//               ),
//               title: Text(videos[1][index]),
//               // subtitle: Text(videos['handle']),
//               trailing: Image.network(videos[2][index]),
//             );
//           } else {
//             return ElevatedButton(
//               onPressed: videos.isEmpty
//                   ? null
//                   : () async {
//                       await fetchVideos((page + 1));
//                     },
//               child: Text('Load More'),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

class _ThumbnailPageState extends State<ThumbnailPage> {
  List<dynamic> videos = [];
  int page = 1;
  bool isLoading = false;

  Future<void> fetchVideos() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(
        Uri.parse('https://internship-service.onrender.com/videos?page=$page'));
    if (response.statusCode == 200) {
      setState(() {
        videos.addAll(json.decode(response.body)['data']['posts']);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            itemCount: (videos.length + 1),
            itemBuilder: (context, index) {
              if (index < videos.length) {
                final video = videos[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => rough.TikTokPage(value: [
                                page,
                                index,
                              ])),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(video['creator']['pic'].toString()),
                  ),
                  title: Text(video['creator']['name'].toString()),
                  subtitle: Text(video['creator']['handle'].toString()),
                  trailing: Image.network(
                      video['submission']['thumbnail'].toString()),
                );
              } else {
                return Container(); // Placeholder for the "Load More" button
              }
            },
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
