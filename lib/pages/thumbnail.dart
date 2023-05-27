import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'shorts.dart' as shorts;

class ThumbnailPage extends StatefulWidget {
  const ThumbnailPage({Key? key}) : super(key: key);

  @override
  _ThumbnailPageState createState() => _ThumbnailPageState();
}

class _ThumbnailPageState extends State<ThumbnailPage> {
  List<dynamic> videos = [];
  int page = 0;
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
          Expanded(
            child: ListView.builder(
              itemCount: (videos.length + 1),
              itemBuilder: (context, index) {
                if (index < videos.length) {
                  final video = videos[index];
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => shorts.YouTubeShortsPage(
                            value: [
                              page,
                              index,
                            ],
                          ),
                        ),
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
                  return Container();
                }
              },
            ),
          ),
          Positioned(
            bottom: 10,
            right: 140,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Positioned(
                    top: 16,
                    right: 3,
                    child: Text(
                      'Current Page : $page',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 47,
            right: 60,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color?>(Colors.greenAccent[400]),
              ),
              onPressed: () {
                videos = [];
                page++;
                fetchVideos();
              },
              child: const Text('Next Page'),
            ),
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          if (page > 0)
            Positioned(
              bottom: 47,
              left: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color?>(Colors.red[400]),
                ),
                onPressed: () {
                  videos = [];
                  page--;
                  fetchVideos();
                },
                child: const Text('Last Page'),
              ),
            ),
        ],
      ),
    );
  }
}
