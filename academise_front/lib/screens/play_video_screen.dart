import 'package:academise_front/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayVideoScreen extends StatefulWidget {
  Map<String, dynamic> videoData;
  PlayVideoScreen({super.key, required this.videoData});

  @override
  State<PlayVideoScreen> createState() => _PlayVideoScreenState();
}

class _PlayVideoScreenState extends State<PlayVideoScreen> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    final videoID =
        YoutubePlayer.convertUrlToId(widget.videoData['video_link']);
    _controller = YoutubePlayerController(
      initialVideoId: videoID.toString(),
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    )..addListener(_onPlayerStateChange);
    super.initState();
  }

  void _onPlayerStateChange() {
    if (_controller.value.playerState == PlayerState.playing) ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Player"),
        backgroundColor: mobileBackgroundColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            onReady: () => debugPrint("Ready"),
            bottomActions: [
              CurrentPosition(),
              ProgressBar(
                isExpanded: true,
                colors: ProgressBarColors(
                  playedColor: purpleColor,
                  handleColor: purpleColor.withOpacity(0.8),
                ),
              ),
              const PlaybackSpeedButton(),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.videoData['video_title'],
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Description:",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: purpleColor,
                      ),
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Mark as Watched",
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(
                  widget.videoData['video_description'],
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
