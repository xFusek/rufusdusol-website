import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class BackgroundMusic extends StatelessWidget {
  const BackgroundMusic({
    required this.controller,
    required this.isPlaying,
    required this.onMusicPressed,
    super.key,
  });

  final YoutubePlayerController? controller;
  final bool isPlaying;
  final VoidCallback onMusicPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 320,
        ),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: controller == null
              ? ColoredBox(
                  color: const Color(0xFF161616),
                  child: Center(
                    child: TextButton.icon(
                      onPressed: onMusicPressed,
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Play the Music'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                )
              : YoutubePlayer(
                  controller: controller!,
                  aspectRatio: 16 / 9,
                  thumbnailFormat: ThumbnailFormat.jpeg,
                ),
        ),
      ),
    );
  }
}
