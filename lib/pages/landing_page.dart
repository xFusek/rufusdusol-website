import 'package:flutter/material.dart';
import 'package:rufusdusol_website/widgets/common/section_divider.dart';
import 'package:rufusdusol_website/widgets/landing/about/about_section.dart';
import 'package:rufusdusol_website/widgets/landing/contact/contact_section.dart';
import 'package:rufusdusol_website/widgets/landing/hero/hero_section.dart';
import 'package:rufusdusol_website/widgets/landing/members/members_section.dart';
import 'package:rufusdusol_website/widgets/common/landing_header.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  static const _responsiveBreakpoint = 1024.0;

  final _aboutSectionKey = GlobalKey();
  final _contactSectionKey = GlobalKey();
  final _membersSectionKey = GlobalKey();

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

    if (item == 'Contact') {
      _scrollToSection(_contactSectionKey);
    } else if (item == 'About Us') {
      _scrollToSection(_aboutSectionKey);
    } else if (item == 'Members') {
      _scrollToSection(_membersSectionKey);
    }
  }

  void _scrollToSection(GlobalKey sectionKey) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final sectionContext = sectionKey.currentContext;
      if (sectionContext == null) return;

      Scrollable.ensureVisible(
        sectionContext,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
        alignment: 0,
      );
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const HeroSection(),
                          const SectionDivider(),
                          AboutSection(key: _aboutSectionKey),
                          const SectionDivider(),
                          MembersSection(key: _membersSectionKey),
                          const SectionDivider(),
                          ContactSection(key: _contactSectionKey),
                        ],
                      ),
                    ),
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
