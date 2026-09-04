import 'package:flutter/material.dart';
import 'package:rufusdusol_website/widgets/landing/hero/hero_artwork.dart';
import 'package:rufusdusol_website/widgets/landing/hero/hero_copy.dart';
import 'package:rufusdusol_website/widgets/landing/hero/music_badge.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    required this.isMusicPlaying,
    required this.onMusicPressed,
    required this.onDiscoverPressed,
    super.key,
  });

  static const _responsiveBreakpoint = 1024.0;

  final bool isMusicPlaying;
  final VoidCallback onMusicPressed;
  final VoidCallback onDiscoverPressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final useVerticalLayout = constraints.maxWidth <= _responsiveBreakpoint;

        if (useVerticalLayout) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(32, 25, 32, 54),
            child: Column(
              children: [
                HeroArtwork(
                  isVertical: true,
                ),
                const SizedBox(height: 34),
                HeroCopy(
                  isVertical: true,
                  onDiscoverPressed: onDiscoverPressed,
                ),
              ],
            ),
          );
        }

        final compact = constraints.maxWidth <= 1280;
        final sectionHeight = compact ? 700.0 : 800.0;
        final badgeSize = compact ? 136.0 : 176.0;

        return SizedBox(
          height: sectionHeight,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Row(
                children: [
                  Expanded(
                    child: HeroCopy(
                      isCompact: compact,
                      onDiscoverPressed: onDiscoverPressed,
                    ),
                  ),
                  Expanded(child: HeroArtwork(isCompact: compact)),
                ],
              ),
              Positioned(
                left: (constraints.maxWidth - badgeSize) / 2,
                top: sectionHeight * 0.6,
                child: MusicBadge(
                  size: badgeSize,
                  isPlaying: isMusicPlaying,
                  onPressed: onMusicPressed,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
