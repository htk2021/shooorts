import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class ShortsScreen extends StatefulWidget {
  final String videoId;
  final VoidCallback onClose;

  ShortsScreen({required this.videoId, required this.onClose});

  @override
  PlayerState createState() => PlayerState(videoId);
}

class PlayerState extends State<ShortsScreen> {
  String _videoID;

  PlayerState(this._videoID);

  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        loop: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.onClose(); // ShortsScreen을 닫을 때 onClose 콜백 실행
        return false;
      },
      child: Container(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.red,
        ),
      ),
    );
  }
}

