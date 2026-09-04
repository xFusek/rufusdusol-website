part of 'about_section.dart';

class _AboutGallery extends StatelessWidget {
  const _AboutGallery({required this.maxWidth});

  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth =
            constraints.hasBoundedWidth ? constraints.maxWidth : maxWidth;
        final width = availableWidth < maxWidth ? availableWidth : maxWidth;
        final height = width * 1.2;

        return SizedBox(
          width: width,
          height: height,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Positioned(
                top: 0,
                right: 0,
                width: width * 0.5,
                height: height * 0.403,
                child: const _AboutImage(
                  assetName: 'assets/images/about1.png',
                  semanticLabel: 'RÜFÜS DU SOL live concert',
                ),
              ),
              Positioned(
                top: height * 0.25,
                left: 0,
                width: width * 0.725,
                height: height * 0.503,
                child: const _AboutImage(
                  assetName: 'assets/images/about2.png',
                  semanticLabel: 'RÜFÜS DU SOL performing live',
                ),
              ),
              Positioned(
                top: height * 0.65,
                right: 0,
                width: width * 0.597,
                height: height * 0.35,
                child: Transform.flip(
                  flipX: true,
                  child: const _AboutImage(
                    assetName: 'assets/images/about3.png',
                    semanticLabel: 'RÜFÜS DU SOL concert crowd',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AboutImage extends StatelessWidget {
  const _AboutImage({required this.assetName, required this.semanticLabel});

  final String assetName;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetName,
      fit: BoxFit.cover,
      semanticLabel: semanticLabel,
    );
  }
}
