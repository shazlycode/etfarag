import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';

class DesktopVideoPlayer extends StatefulWidget {
  const DesktopVideoPlayer({Key? key, this.url}) : super(key: key);
  final String? url;

  @override
  State<DesktopVideoPlayer> createState() => _DesktopVideoPlayerState();
}

class _DesktopVideoPlayerState extends State<DesktopVideoPlayer> {
  final player = Player(id: 69420);

  @override
  void initState() {
    // TODO: implement initState
    final media2 = Media.network(widget.url);
    super.initState();
    player.open(
      media2,
      autoStart: true, // default
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desktop Youtube Player'),
      ),
      body: Video(
        player: player,
        height: 1920.0,
        width: 1080.0,
        scale: 1.0, // default
        showControls: false, // default
      ),
    );
  }
}
