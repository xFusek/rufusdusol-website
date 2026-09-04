import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rufusdusol_website/widgets/common/background_music.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

part 'contact_layout.dart';
part 'contact_links.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({
    required this.musicController,
    required this.isMusicPlaying,
    required this.onMusicPressed,
    super.key,
  });

  static const _responsiveBreakpoint = 1180.0;

  final YoutubePlayerController? musicController;
  final bool isMusicPlaying;
  final VoidCallback onMusicPressed;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final useVerticalLayout =
              constraints.maxWidth <= _responsiveBreakpoint;

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: useVerticalLayout ? 24 : 70,
              vertical: useVerticalLayout ? 40 : 70,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1385),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (useVerticalLayout)
                      _MobileFooterContent(
                        musicController: musicController,
                        isMusicPlaying: isMusicPlaying,
                        onMusicPressed: onMusicPressed,
                      )
                    else
                      _DesktopFooterContent(
                        musicController: musicController,
                        isMusicPlaying: isMusicPlaying,
                        onMusicPressed: onMusicPressed,
                      ),
                    const SizedBox(height: 45),
                    const Text(
                      '© 2025 RÜFÜS DU SOL.\nAll Rights Reserved.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Mulish',
                        fontSize: 16,
                        height: 1.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
