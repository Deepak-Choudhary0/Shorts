import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class YouTubeShortsPage extends StatefulWidget {
  late List value;
  YouTubeShortsPage({required this.value});
  @override
  _YouTubeShortsPageState createState() =>
      _YouTubeShortsPageState(value: value);
}

class _YouTubeShortsPageState extends State<YouTubeShortsPage> {
  _YouTubeShortsPageState({required this.value});

  late List value;
  List<dynamic> incomingData = [];
  List<String> videoList = [];
  List<dynamic> video = [];
  List pic = [];
  List title = ['Trending Title'];
  List name = [];
  List description = ['Description❤'];
  List handle = [];
  List likes = [];
  int page = 0;
  ScrollController _scrollController = ScrollController();
  List<ChewieController> chewieControllers = [];
  ChewieController? _currentlyPlayingController;
  bool isLoading = false;
  int indexVideo = 0;

  @override
  void initState() {
    super.initState();
    page = value[0];
    indexVideo = value[1];
    fetchVideos(page, indexVideo);
  }

  void fetchVideos(page, index) async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(
        Uri.parse('https://internship-service.onrender.com/videos?page=$page'));
    if (response.statusCode == 200) {
      int j = 0;
      for (var i = index; i < 10; i++) {
        print(i);
        incomingData.add(json.decode(response.body)['data']['posts'][i]);
        video.add(incomingData[j]['submission']['mediaUrl'].toString());
        pic.add(incomingData[j]['creator']['pic'].toString());
        name.add(incomingData[j]['creator']['name'].toString());
        handle.add(incomingData[j]['creator']['handle'].toString());
        title.add(incomingData[j]['submission']['title'].toString());
        description
            .add(incomingData[j]['submission']['description'].toString());
        likes.add(incomingData[j]['reaction']['count'].toInt());
        j++;
      }
      initializeChewieControllers();
      _scrollController.addListener(scrollListener);
      _scrollController.addListener(_handleScroll);
      isLoading = false;
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void scrollListener() {
    // if (_scrollController.position.pixels ==
    //     _scrollController.position.maxScrollExtent) {
    //   if (!isLoading) {
    //     page++;
    //     fetchVideos(page, indexVideo);
    //   }
    // }
  }

  void initializeChewieControllers() {
    if (video.length.toString().isEmpty) {
    } else {
      for (var i = 0; i < video.length; i++) {
        final videoUrl = video[i];
        print(videoUrl);
        final videoPlayerController = VideoPlayerController.network(videoUrl);
        videoPlayerController.initialize().then((_) {
          setState(() {});
        });
        final chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          autoPlay: false,
          looping: false,
        );
        chewieControllers.add(chewieController);
      }
    }
  }

  void _handleScroll() {
    for (var i = 0; i < chewieControllers.length; i++) {
      final chewieController = chewieControllers[i];
      if (chewieController.videoPlayerController.value.isPlaying &&
          chewieController != _currentlyPlayingController) {
        chewieController.pause();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: _scrollController,
        itemCount: video.length,
        itemBuilder: (context, index) {
          final chewieController = chewieControllers[index];
          if (index < video.length) {
            return Stack(
              children: [
                Chewie(
                  controller: chewieController,
                ),
                Positioned(
                  top: 50,
                  left: 13,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              pic[index]), // Replace with your profile picture
                          radius: 16,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          children: [
                            Text(
                              title[0],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              description[0],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              name[index],
                              style: TextStyle(
                                color: Colors.limeAccent[700],
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 70,
                  right: 10,
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
                            'Likes : ' + likes[index].toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
  //------------------------------------------------
}
