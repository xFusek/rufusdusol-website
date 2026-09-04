import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rufusdusol_website/widgets/common/section_divider.dart';
import 'package:rufusdusol_website/widgets/landing/about/about_section.dart';
import 'package:rufusdusol_website/widgets/landing/contact/contact_section.dart';
import 'package:rufusdusol_website/widgets/landing/hero/hero_section.dart';
import 'package:rufusdusol_website/widgets/landing/members/members_section.dart';
import 'package:rufusdusol_website/widgets/landing/tickets/tickets_section.dart';
import 'package:rufusdusol_website/widgets/common/landing_header.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  static const _responsiveBreakpoint = 1024.0;
  static final _soundCloudUrl = Uri.parse('https://soundcloud.com/rufusdusol');

  final _scrollController = ScrollController();
  final _sectionKeys = <String, GlobalKey>{
    'Home': GlobalKey(),
    'About Us': GlobalKey(),
    'Members': GlobalKey(),
    'Tickets': GlobalKey(),
    'Contact': GlobalKey(),
  };

  bool _isMenuOpen = false;
  bool _isProgrammaticScroll = false;
  bool _isMusicPlaying = false;
  YoutubePlayerController? _musicController;
  StreamSubscription<YoutubePlayerValue>? _musicStateSubscription;
  String _selectedNavigationItem = 'Home';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _musicStateSubscription?.cancel();
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();
    _musicController?.close();
    super.dispose();
  }

  void _toggleMusic() {
    final controller = _musicController;

    if (controller == null) {
      final newController = YoutubePlayerController.fromVideoId(
        videoId: 'Tx9zMFodNtA',
        autoPlay: true,
        params: const YoutubePlayerParams(
          loop: true,
          mute: false,
          showControls: true,
          showFullscreenButton: false,
          privacyEnhancedMode: true,
        ),
      );

      _musicStateSubscription = newController.listen(
        _handleMusicStateChanged,
      );

      setState(() {
        _musicController = newController;
        _isMusicPlaying = true;
      });
      return;
    }

    setState(() => _isMusicPlaying = !_isMusicPlaying);

    if (_isMusicPlaying) {
      controller.playVideo();
    } else {
      controller.pauseVideo();
    }
  }

  void _handleMusicStateChanged(YoutubePlayerValue value) {
    final bool isPlaying;

    switch (value.playerState) {
      case PlayerState.playing:
        isPlaying = true;
      case PlayerState.paused:
      case PlayerState.ended:
        isPlaying = false;
      default:
        return;
    }

    if (mounted && isPlaying != _isMusicPlaying) {
      setState(() => _isMusicPlaying = isPlaying);
    }
  }

  Future<void> _openSoundCloud() async {
    final wasOpened = await launchUrl(
      _soundCloudUrl,
      mode: LaunchMode.externalApplication,
    );

    if (!wasOpened && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open SoundCloud.')),
      );
    }
  }

  void _toggleMenu() {
    setState(() => _isMenuOpen = !_isMenuOpen);
  }

  void _selectNavigationItem(String item) {
    setState(() {
      _selectedNavigationItem = item;
      _isMenuOpen = false;
    });

    final sectionKey = _sectionKeys[item];
    if (sectionKey != null) _scrollToSection(sectionKey);
  }

  void _scrollToSection(GlobalKey sectionKey) {
    _isProgrammaticScroll = true;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;

      final sectionContext = sectionKey.currentContext;
      if (sectionContext == null) {
        _isProgrammaticScroll = false;
        return;
      }

      try {
        await Scrollable.ensureVisible(
          sectionContext,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOutCubic,
          alignment: 0,
        );
      } finally {
        if (mounted) {
          _isProgrammaticScroll = false;
          _updateSelectedNavigationItem();
        }
      }
    });
  }

  void _handleScroll() {
    if (!_isProgrammaticScroll) _updateSelectedNavigationItem();
  }

  void _updateSelectedNavigationItem() {
    if (!mounted || !_scrollController.hasClients) return;

    var activeItem = 'Home';
    final viewportSize = MediaQuery.sizeOf(context);
    final headerHeight =
        viewportSize.width <= _responsiveBreakpoint ? 70.0 : 100.0;
    final activationLine = headerHeight + (viewportSize.height * 0.2);

    for (final entry in _sectionKeys.entries) {
      final sectionContext = entry.value.currentContext;
      final renderObject = sectionContext?.findRenderObject();

      if (renderObject is RenderBox && renderObject.attached) {
        final sectionTop = renderObject.localToGlobal(Offset.zero).dy;
        if (sectionTop <= activationLine) activeItem = entry.key;
      }
    }

    if (_scrollController.position.extentAfter <= 1) {
      activeItem = 'Contact';
    }

    if (activeItem != _selectedNavigationItem) {
      setState(() => _selectedNavigationItem = activeItem);
    }
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
                      controller: _scrollController,
                      child: Column(
                        children: [
                          HeroSection(
                            key: _sectionKeys['Home'],
                            isMusicPlaying: _isMusicPlaying,
                            onMusicPressed: _toggleMusic,
                            onDiscoverPressed: _openSoundCloud,
                          ),
                          const SectionDivider(),
                          AboutSection(key: _sectionKeys['About Us']),
                          const SectionDivider(),
                          MembersSection(key: _sectionKeys['Members']),
                          const SectionDivider(),
                          TicketsSection(key: _sectionKeys['Tickets']),
                          ContactSection(
                            key: _sectionKeys['Contact'],
                            musicController: _musicController,
                            isMusicPlaying: _isMusicPlaying,
                            onMusicPressed: _toggleMusic,
                          ),
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
