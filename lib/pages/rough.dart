import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TikTokPage extends StatefulWidget {
  late List value;
  TikTokPage({required this.value});
  @override
  _TikTokPageState createState() => _TikTokPageState(value: value);
}

class _TikTokPageState extends State<TikTokPage> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  late List value;
  _TikTokPageState({required this.value});
  bool _hasError = false;
  List<dynamic> videos = [];
  String video = '';
  String pic = '';
  String title = '';
  String name = '';
  String description = '';
  String handle = '';
  String likes = '';
  int page = 0;
  bool isLoading = true;
  int indexVideo = 0;
  @override
  void initState() {
    super.initState();
    _hasError = false;
    page = value[0];
    indexVideo = value[1];

    Future<void> fetchVideos(page, index) async {
      setState(() {
        isLoading = true;
      });

      final response = await http.get(Uri.parse(
          'https://internship-service.onrender.com/videos?page=$page'));
      if (response.statusCode == 200) {
        setState(() {
          videos
              .add(json.decode(response.body)['data']['posts'][index.toInt()]);
          isLoading = false;

          video = videos[0]['submission']['mediaUrl'].toString();
          pic = videos[0]['creator']['pic'].toString();
          name = videos[0]['creator']['name'].toString();
          handle = videos[0]['creator']['handle'].toString();
          title = videos[0]['submission']['title'].toString();
          description = videos[0]['submission']['description'].toString();
          likes = videos[0]['reaction']['count'].toString();
          print(video.runtimeType);
          _videoPlayerController = VideoPlayerController.network(video);
          _chewieController = ChewieController(
            videoPlayerController: _videoPlayerController,
            autoPlay: true,
            looping: true,
            customControls: CustomMaterialControls(),
          );
        });
      } else {
        setState(() {
          isLoading = true;
        });
      }
    }

    fetchVideos(page, indexVideo);
  }

  // @override
  // void dispose() {
  //   _videoPlayerController.dispose();
  //   _chewieController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Video Page'),
        ),
        body: Stack(
          children: [
            ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Handle tap on video item
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 9 / 16,
                        child: Chewie(
                          controller: _chewieController,
                        ),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(pic),
                        ),
                        title: Text(name),
                        subtitle: Text(handle),
                        trailing: Text('Likes : ' + likes),
                      ),
                    ],
                  ),
                );
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
}

class CustomMaterialControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: MaterialControls(),
    );
  }
}
