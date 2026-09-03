import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LandingHeader extends StatelessWidget {
  const LandingHeader({
    required this.isMobile,
    required this.isMenuOpen,
    required this.selectedItem,
    required this.onMenuPressed,
    required this.onNavigationPressed,
    super.key,
  });

  static const _navigationItems = [
    'Home',
    'About Us',
    'Members',
    'Tickets',
    'Contact',
  ];

  final bool isMobile;
  final bool isMenuOpen;
  final String selectedItem;
  final VoidCallback onMenuPressed;
  final ValueChanged<String> onNavigationPressed;

  @override
  Widget build(BuildContext context) {
    final height = isMobile ? 70.0 : 100.0;

    return Material(
      color: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: height,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1600),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 20 : 48,
                  ),
                  child: Row(
                    children: [
                      if (isMobile) ...[
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: SvgPicture.asset(
                              'assets/images/logo.svg',
                              width: 125,
                              fit: BoxFit.contain,
                              semanticsLabel: 'RÜFÜS DU SOL logo',
                            ),
                          ),
                        ),
                        _MenuButton(
                          isOpen: isMenuOpen,
                          onPressed: onMenuPressed,
                        ),
                      ] else ...[
                        SvgPicture.asset(
                          'assets/images/logo.svg',
                          width: 158,
                          semanticsLabel: 'RÜFÜS DU SOL logo',
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (final item in _navigationItems)
                                _NavigationItem(
                                  label: item,
                                  isSelected: item == selectedItem,
                                  onPressed: () => onNavigationPressed(item),
                                ),
                            ],
                          ),
                        ),
                        _ReachOutButton(
                          onPressed: () => onNavigationPressed('Contact'),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isMobile)
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              child: isMenuOpen
                  ? Container(
                      key: const ValueKey('mobile-navigation'),
                      width: double.infinity,
                      color: Colors.black,
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Column(
                        children: [
                          for (final item in _navigationItems)
                            TextButton(
                              onPressed: () => onNavigationPressed(item),
                              style: TextButton.styleFrom(
                                minimumSize: const Size.fromHeight(42),
                                foregroundColor: Colors.white,
                              ),
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
        ],
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            final isHighlighted =
                states.contains(WidgetState.hovered) ||
                states.contains(WidgetState.pressed) ||
                isSelected;

            return isHighlighted ? Colors.white : const Color(0xFF9E9E9E);
          }),
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          splashFactory: NoSplash.splashFactory,
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          ),
          textStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
            final isHighlighted =
                states.contains(WidgetState.hovered) ||
                states.contains(WidgetState.pressed) ||
                isSelected;

            return TextStyle(
              fontSize: 14,
              fontWeight: isHighlighted ? FontWeight.w800 : FontWeight.w700,
            );
          }),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label),
            const SizedBox(height: 4),
            SizedBox(
              width: 8,
              height: 8,
              child: isSelected
                  ? const DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _ReachOutButton extends StatelessWidget {
  const _ReachOutButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 58,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: const RoundedRectangleBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/phone-icon.svg',
              width: 18,
              height: 18,
            ),
            const SizedBox(width: 10),
            const Text(
              'Reach Out',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({required this.isOpen, required this.onPressed});

  final bool isOpen;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      color: Colors.white,
      tooltip: isOpen ? 'Close navigation' : 'Open navigation',
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 180),
        child: Icon(
          isOpen ? Icons.close : Icons.menu,
          key: ValueKey(isOpen),
          size: 30,
        ),
      ),
    );
  }
}
