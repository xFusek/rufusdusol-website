import 'package:flutter/material.dart';
import 'package:rufusdusol_website/widgets/hero_section.dart';
import 'package:rufusdusol_website/widgets/landing_header.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  static const _responsiveBreakpoint = 1024.0;

  bool _isMenuOpen = false;
  String _selectedNavigationItem = 'Home';

  void _toggleMenu() {
    setState(() => _isMenuOpen = !_isMenuOpen);
  }

  void _selectNavigationItem(String item) {
    setState(() {
      _selectedNavigationItem = item;
      _isMenuOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth <= _responsiveBreakpoint;
          final headerHeight = isMobile ? 70.0 : 100.0;

          return Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: headerHeight),
                  const Expanded(
                    child: SingleChildScrollView(child: HeroSection()),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topCenter,
                child: LandingHeader(
                  isMobile: isMobile,
                  isMenuOpen: _isMenuOpen,
                  selectedItem: _selectedNavigationItem,
                  onMenuPressed: _toggleMenu,
                  onNavigationPressed: _selectNavigationItem,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
