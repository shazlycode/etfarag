import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
    // const url = 'https://youtu.be/5NrS0WZSM8k';

    controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.url)!)
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
  }

  @override
  void deactivate() {
    controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(controller: controller),
        builder: (context, player) {
          return Scaffold(
            appBar: AppBar(title: Text('Youtube Player')),
            body: ListView(children: [
              player,
              Text(
                controller.metadata.title,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(
                height: 10,
              ),
              Text(controller.value.isPlaying
                  ? controller.metadata.duration.toString().substring(0, 7)
                  : ''),
            ]),
          );
        });
  }
}
