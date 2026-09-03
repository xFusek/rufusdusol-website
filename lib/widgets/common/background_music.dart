import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class BackgroundMusic extends StatefulWidget {
  const BackgroundMusic({super.key});

  @override
  State<BackgroundMusic> createState() => _BackgroundMusicState();
}

class _BackgroundMusicState extends State<BackgroundMusic> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController.fromVideoId(
      videoId: 'Tx9zMFodNtA',
      autoPlay: true,
      params: const YoutubePlayerParams(
        loop: true,
        mute: false,
        showControls: true,
        showFullscreenButton: false,
        privacyEnhancedMode: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 320,
        ),
        child: YoutubePlayer(
          controller: _controller,
          aspectRatio: 16 / 9,
          thumbnailFormat: ThumbnailFormat.jpeg,
        ),
      ),
    );
  }
}
