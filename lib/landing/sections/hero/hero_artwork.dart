import 'package:flutter/material.dart';
import 'package:rufusdusol_website/landing/sections/hero/hero_carousel.dart';

class HeroArtwork extends StatelessWidget {
  const HeroArtwork({
    this.isVertical = false,
    this.isCompact = false,
    super.key,
  });

  final bool isVertical;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final imageSize = isVertical ? 400.0 : (isCompact ? 500.0 : 600.0);
    final content = HeroCarousel(maximumImageSize: imageSize);

    if (isVertical) return content;

    return SizedBox.expand(
      child: ColoredBox(
        color: const Color(0xFFE8E8E8),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isCompact ? 40 : 60,
              vertical: 42,
            ),
            child: content,
          ),
        ),
      ),
    );
  }
}
