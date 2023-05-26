import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class TikTokPage extends StatefulWidget {
  @override
  _TikTokPageState createState() => _TikTokPageState();
}

class _TikTokPageState extends State<TikTokPage> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
        'https://cdn.gro.care/755d5af44c54_1683463531570.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Page'),
      ),
      body: ListView.builder(
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
                    backgroundImage: NetworkImage(
                        'https://cdn.gro.care/6ce188269916_1667990600681.bin'),
                  ),
                  title: Text('Hot Video'),
                  subtitle: Text('Like and Follow'),
                  trailing: Text('Likes: 100'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
