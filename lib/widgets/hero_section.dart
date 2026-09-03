import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  static const _responsiveBreakpoint = 1024.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final useVerticalLayout =
            constraints.maxWidth <= _responsiveBreakpoint;

        if (useVerticalLayout) {
          return const Padding(
            padding: EdgeInsets.fromLTRB(32, 25, 32, 54),
            child: Column(
              children: [
                _HeroArtwork(isVertical: true),
                SizedBox(height: 34),
                _HeroCopy(isVertical: true),
              ],
            ),
          );
        }

        final compact = constraints.maxWidth <= 1280;
        return SizedBox(
          height: compact ? 700 : 800,
          child: Row(
            children: [
              Expanded(child: _HeroCopy(isCompact: compact)),
              Expanded(child: _HeroArtwork(isCompact: compact)),
            ],
          ),
        );
      },
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({this.isVertical = false, this.isCompact = false});

  final bool isVertical;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final titleSize = isVertical ? 38.0 : (isCompact ? 48.0 : 54.0);
    final horizontalPadding = isCompact ? 40.0 : 70.0;

    final copy = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 540),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: isVertical
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Text(
            'Rhythm & Emotion in Sync',
            textAlign: isVertical ? TextAlign.center : TextAlign.left,
            style: TextStyle(
              fontFamily: 'Gothic A1',
              fontSize: isVertical ? 17 : 20,
              height: 1.5,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 25),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: 'Feel The '),
                TextSpan(
                  text: 'Pulse',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const TextSpan(text: ' Of\nRÜFÜS DU SOL'),
              ],
            ),
            textAlign: isVertical ? TextAlign.center : TextAlign.left,
            style: TextStyle(
              fontFamily: 'Space Grotesk',
              fontSize: titleSize,
              height: 1.2,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 25),
          Text(
            'Immerse yourself in atmospheric soundscapes. From raw emotion '
            'to hypnotic rhythms — this is music that moves.',
            textAlign: isVertical ? TextAlign.center : TextAlign.left,
            style: const TextStyle(
              color: Color(0xFF898989),
              fontSize: 16,
              height: 1.625,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 25),
          _DiscoverButton(onPressed: () {}),
        ],
      ),
    );

    if (isVertical) {
      return copy;
    }

    return ColoredBox(
      color: Colors.white,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          _HeroBackgroundDecorations(isCompact: isCompact),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: copy,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroBackgroundDecorations extends StatelessWidget {
  const _HeroBackgroundDecorations({required this.isCompact});

  static const _decorationEdgeInset = 20.0;

  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isCompact ? 32 : 60,
          vertical: _decorationEdgeInset,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            _HeroBackgroundAsset(
              assetName: 'assets/images/background_circles1.svg',
            ),
            _HeroBackgroundAsset(
              assetName: 'assets/images/background_circles2.svg',
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroBackgroundAsset extends StatelessWidget {
  const _HeroBackgroundAsset({required this.assetName});

  final String assetName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: SvgPicture.asset(
        assetName,
        fit: BoxFit.contain,
        alignment: Alignment.center,
      ),
    );
  }
}

class _DiscoverButton extends StatelessWidget {
  const _DiscoverButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 235,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(border: Border.all(width: 2)),
      child: SizedBox(
        height: 68,
        child: FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: const RoundedRectangleBorder(),
          ),
          child: const Text(
            'Discover the Music',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}

class _HeroArtwork extends StatelessWidget {
  const _HeroArtwork({this.isVertical = false, this.isCompact = false});

  final bool isVertical;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final imageSize = isVertical ? 400.0 : (isCompact ? 500.0 : 600.0);

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: imageSize,
            maxHeight: imageSize,
          ),
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.asset(
              'assets/images/hero_image1.png',
              fit: BoxFit.cover,
              alignment: Alignment.center,
              semanticLabel: 'RÜFÜS DU SOL band',
            ),
          ),
        ),
        const SizedBox(height: 25),
        const _CarouselDots(),
      ],
    );

    if (isVertical) {
      return content;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final badgeSize = isCompact ? 136.0 : 176.0;

        return SizedBox.expand(
          child: ColoredBox(
            color: const Color(0xFFE8E8E8),
            child: Stack(
              clipBehavior: Clip.none,
              fit: StackFit.expand,
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isCompact ? 40 : 60,
                      vertical: 42,
                    ),
                    child: content,
                  ),
                ),
                Positioned(
                  left: -(badgeSize / 2),
                  top: constraints.maxHeight * 0.6,
                  child: SvgPicture.asset(
                    'assets/images/badge.svg',
                    width: badgeSize,
                    height: badgeSize,
                    semanticsLabel: 'Join now',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CarouselDots extends StatelessWidget {
  const _CarouselDots();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var index = 0; index < 3; index++) ...[
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: index == 0 ? Colors.black : const Color(0xFFA3A3A3),
              shape: BoxShape.circle,
            ),
          ),
          if (index < 2) const SizedBox(width: 25),
        ],
      ],
    );
  }
}
