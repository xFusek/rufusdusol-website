part of 'contact_section.dart';

class _DesktopFooterContent extends StatelessWidget {
  const _DesktopFooterContent();

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _ContactDetails()),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: BackgroundMusic(),
          ),
        ),
        Expanded(child: _FooterLinks()),
      ],
    );
  }
}

class _MobileFooterContent extends StatelessWidget {
  const _MobileFooterContent();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ContactDetails(centered: true),
        SizedBox(height: 40),
        BackgroundMusic(),
        SizedBox(height: 40),
        _FooterLinks(centered: true),
      ],
    );
  }
}

class _ContactDetails extends StatelessWidget {
  const _ContactDetails({this.centered = false});

  final bool centered;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          'assets/images/logo.svg',
          height: 40,
          fit: BoxFit.contain,
          semanticsLabel: 'RÜFÜS DU SOL logo',
        ),
        const SizedBox(height: 20),
        const _FooterTextLine(
          label: 'Contact Us:',
          value: 'info@rufusdusol.com',
        ),
        const _FooterTextLine(label: 'Phone:', value: '+1 800-123-456'),
      ],
    );
  }
}

class _FooterTextLine extends StatelessWidget {
  const _FooterTextLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$label ',
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          TextSpan(text: value),
        ],
      ),
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: 'Mulish',
        fontSize: 16,
        height: 2.5,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }
}
