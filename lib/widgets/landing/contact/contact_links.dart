part of 'contact_section.dart';

class _FooterLinks extends StatelessWidget {
  const _FooterLinks({this.centered = false});

  final bool centered;

  @override
  Widget build(BuildContext context) {
    if (centered) {
      return Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _LegalLinks(expanded: true),
              SizedBox(height: 56),
              _FollowUs(expanded: true),
            ],
          ),
        ),
      );
    }

    return const Wrap(
      alignment: WrapAlignment.end,
      crossAxisAlignment: WrapCrossAlignment.start,
      spacing: 32,
      runSpacing: 40,
      children: [_FollowUs(), _LegalLinks()],
    );
  }
}

class _FollowUs extends StatelessWidget {
  const _FollowUs({this.expanded = false});

  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return _FooterGroup(
      title: 'Follow Us:',
      fullWidth: expanded,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth =
              constraints.hasBoundedWidth ? constraints.maxWidth : 144.0;

          if (availableWidth <= 0) {
            return const SizedBox.shrink();
          }

          final rowWidth = availableWidth > 144 ? 144.0 : availableWidth;
          final iconSize = ((rowWidth / 4) - 8).clamp(1.0, 21.0).toDouble();

          return SizedBox(
            width: rowWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _SocialIcon(
                  assetName: 'assets/images/instagram.svg',
                  size: iconSize,
                ),
                _SocialIcon(
                  assetName: 'assets/images/x.svg',
                  size: iconSize,
                ),
                _SocialIcon(
                  assetName: 'assets/images/spotify.svg',
                  size: iconSize,
                ),
                _SocialIcon(
                  assetName: 'assets/images/facebook.svg',
                  size: iconSize,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _LegalLinks extends StatelessWidget {
  const _LegalLinks({this.expanded = false});

  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return _FooterGroup(
      title: 'Links:',
      fullWidth: expanded,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FooterLink(label: 'Privacy Policy'),
          SizedBox(height: 24),
          _FooterLink(label: 'Terms of Service'),
        ],
      ),
    );
  }
}

class _FooterGroup extends StatelessWidget {
  const _FooterGroup({
    required this.title,
    required this.child,
    this.fullWidth = false,
  });

  final String title;
  final Widget child;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Mulish',
              fontSize: 16,
              height: 2.5,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          Container(
            width: fullWidth ? double.infinity : 144,
            height: 1,
            color: Colors.white,
          ),
          const SizedBox(height: 15),
          child,
        ],
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  const _SocialIcon({required this.assetName, required this.size});

  final String assetName;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(assetName, width: size, height: size);
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontFamily: 'Mulish',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }
}
