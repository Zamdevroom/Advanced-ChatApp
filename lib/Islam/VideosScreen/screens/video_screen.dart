import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';

class VideoScreen extends StatefulWidget {
  final String id;
  final String desc;

  VideoScreen({required this.id, required this.desc});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: YoutubePlayerFlags(
        showLiveFullscreenButton: true,
        mute: false,
        autoPlay: true,
        enableCaption: true,
      ),
    );

    _controller.addListener(() {
      if (_controller.value.isFullScreen) {
        // Entering fullscreen, hide the notification bar and lock orientation
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
        SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
      } else {
        // Exiting fullscreen, restore orientation and show notification bar
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  onReady: () {
                    print(_controller.metadata);
                    print('Player is ready.');
                  },
                ),
                builder: (context, player) {
                  return Column(
                    children: [
                      player,
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          widget.desc,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Restore UI settings on dispose
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _controller.dispose();
    super.dispose();
  }
}
