import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MusicBadge extends StatefulWidget {
  const MusicBadge({
    required this.size,
    required this.isPlaying,
    required this.onPressed,
    super.key,
  });

  final double size;
  final bool isPlaying;
  final VoidCallback onPressed;

  @override
  State<MusicBadge> createState() => _MusicBadgeState();
}

class _MusicBadgeState extends State<MusicBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    if (widget.isPlaying) _rotationController.repeat();
  }

  @override
  void didUpdateWidget(covariant MusicBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying == oldWidget.isPlaying) return;

    if (widget.isPlaying) {
      _rotationController.repeat();
    } else {
      _rotationController.stop();
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: widget.isPlaying ? 'Pause the music' : 'Play the music',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onPressed,
          behavior: HitTestBehavior.opaque,
          child: SizedBox.square(
            dimension: widget.size,
            child: Stack(
              alignment: Alignment.center,
              children: [
                RotationTransition(
                  turns: _rotationController,
                  child: SvgPicture.asset(
                    'assets/images/badge.svg',
                    width: widget.size,
                    height: widget.size,
                    semanticsLabel: 'Join now',
                  ),
                ),
                Container(
                  width: widget.size * 0.52,
                  height: widget.size * 0.52,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.isPlaying ? Icons.pause : Icons.play_arrow,
                    size: widget.size * 0.34,
                    color: const Color(0xFF969696),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
