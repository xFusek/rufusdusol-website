part of 'hero_section.dart';

class _HeroArtwork extends StatelessWidget {
  const _HeroArtwork({this.isVertical = false, this.isCompact = false});

  final bool isVertical;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final imageSize = isVertical ? 400.0 : (isCompact ? 500.0 : 600.0);
    final content = _HeroCarousel(maximumImageSize: imageSize);

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

class _HeroCarousel extends StatefulWidget {
  const _HeroCarousel({required this.maximumImageSize});

  final double maximumImageSize;

  @override
  State<_HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<_HeroCarousel> {
  static const _slideDuration = Duration(milliseconds: 600);
  static const _automaticChangeInterval = Duration(seconds: 5);
  static const _images = [
    'assets/images/hero_image1.png',
    'assets/images/hero_image2.png',
    'assets/images/hero_image3.png',
  ];

  late final PageController _pageController;
  Timer? _automaticChangeTimer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _automaticChangeTimer = Timer.periodic(
      _automaticChangeInterval,
      (_) => _showNextImage(),
    );
  }

  void _showNextImage() {
    if (!mounted || !_pageController.hasClients) {
      return;
    }

    final nextIndex = (_currentIndex + 1) % _images.length;
    _pageController.animateToPage(
      nextIndex,
      duration: _slideDuration,
      curve: Curves.easeInOut,
    );
  }

  void _showImage(int index) {
    if (!_pageController.hasClients || index == _currentIndex) {
      return;
    }

    _pageController.animateToPage(
      index,
      duration: _slideDuration,
      curve: Curves.easeInOut,
    );
  }

  void _handlePageChanged(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  void dispose() {
    _automaticChangeTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: widget.maximumImageSize,
            maxHeight: widget.maximumImageSize,
          ),
          child: AspectRatio(
            aspectRatio: 1,
            child: ScrollConfiguration(
              behavior: const MaterialScrollBehavior().copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.trackpad,
                  PointerDeviceKind.stylus,
                },
              ),
              child: PageView.builder(
                controller: _pageController,
                itemCount: _images.length,
                onPageChanged: _handlePageChanged,
                itemBuilder: (context, index) {
                  return Image.asset(
                    _images[index],
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    semanticLabel: 'RÜFÜS DU SOL band — image ${index + 1}',
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 25),
        _CarouselDots(
          count: _images.length,
          currentIndex: _currentIndex,
          onSelected: _showImage,
        ),
      ],
    );
  }
}

class _CarouselDots extends StatelessWidget {
  const _CarouselDots({
    required this.count,
    required this.currentIndex,
    required this.onSelected,
  });

  final int count;
  final int currentIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var index = 0; index < count; index++) ...[
          Semantics(
            button: true,
            selected: index == currentIndex,
            label: 'Show image ${index + 1}',
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => onSelected(index),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: index == currentIndex
                          ? Colors.black
                          : const Color(0xFFA3A3A3),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (index < count - 1) const SizedBox(width: 10),
        ],
      ],
    );
  }
}
