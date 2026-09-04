part of 'members_section.dart';

class _MemberData {
  const _MemberData({
    required this.name,
    required this.role,
    required this.imageAsset,
  });

  final String name;
  final String role;
  final String imageAsset;
}

class _MemberCard extends StatelessWidget {
  const _MemberCard({required this.member, this.compact = false});

  final _MemberData member;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = compact ? 25.0 : 45.0;
    final contentGap = compact ? 15.0 : 20.0;

    return ColoredBox(
      color: const Color(0xB3000000),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          compact ? 25 : 45,
          horizontalPadding,
          20,
        ),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Image.asset(
                  member.imageAsset,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  semanticLabel: member.name,
                ),
              ),
            ),
            SizedBox(height: contentGap),
            Text(
              member.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Space Grotesk',
                fontSize: compact ? 26 : 28,
                height: compact ? 1.35 : 1.5,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: contentGap),
            Text(
              member.role,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Mulish',
                fontSize: 16,
                height: 1.5,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: contentGap),
            Container(
              width: 128,
              height: 2,
              decoration: BoxDecoration(
                color: const Color(0xFF898989),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: contentGap),
            const _MemberSocialIcons(),
          ],
        ),
      ),
    );
  }
}

class _MemberSocialIcons extends StatelessWidget {
  const _MemberSocialIcons();

  static const _iconAssets = [
    'assets/images/instagram_button.svg',
    'assets/images/x_button.svg',
    'assets/images/spotify_button.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth =
            constraints.hasBoundedWidth ? constraints.maxWidth : 142.0;

        if (availableWidth <= 0) {
          return const SizedBox.shrink();
        }

        final iconSize =
            ((availableWidth - 16) / 3).clamp(1.0, 34.0).toDouble();
        final gap =
            ((availableWidth - (iconSize * 3)) / 2).clamp(0.0, 20.0).toDouble();

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var index = 0; index < _iconAssets.length; index++) ...[
              SvgPicture.asset(
                _iconAssets[index],
                width: iconSize,
                height: iconSize,
              ),
              if (index != _iconAssets.length - 1) SizedBox(width: gap),
            ],
          ],
        );
      },
    );
  }
}
