import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

part 'about_gallery.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  static const _responsiveBreakpoint = 1280.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final useVerticalLayout = constraints.maxWidth <= _responsiveBreakpoint;

        return ClipRect(
          child: Stack(
            children: [
              Positioned(
                top: useVerticalLayout ? -100 : -145,
                left: constraints.maxWidth * 0.45,
                child: IgnorePointer(
                  child: Opacity(
                    opacity: 0.7,
                    child: SvgPicture.asset(
                      'assets/images/vinyl_background_vector.svg',
                      width: useVerticalLayout ? 800 : 1109,
                      height: useVerticalLayout ? 800 : 1109,
                      semanticsLabel: 'Vinyl record decoration',
                    ),
                  ),
                ),
              ),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1600),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: useVerticalLayout ? 40 : 70,
                      vertical: useVerticalLayout ? 50 : 70,
                    ),
                    child: useVerticalLayout
                        ? const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _AboutGallery(maxWidth: 500),
                              SizedBox(height: 50),
                              _AboutCopy(centered: true),
                            ],
                          )
                        : const SizedBox(
                            height: 660,
                            child: Row(
                              children: [
                                _AboutGallery(maxWidth: 550),
                                SizedBox(width: 100),
                                Expanded(child: _AboutCopy()),
                              ],
                            ),
                          ),
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

class _AboutCopy extends StatelessWidget {
  const _AboutCopy({this.centered = false});

  final bool centered;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Align(
            alignment: centered ? Alignment.center : Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(60),
              ),
              child: const Text(
                'About Us',
                style: TextStyle(
                  fontFamily: 'Gothic A1',
                  fontSize: 22,
                  height: 1,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Text.rich(
            const TextSpan(
              children: [
                TextSpan(text: 'Our Mission Is To Turn '),
                TextSpan(
                  text: 'Emotion',
                  style: TextStyle(color: Color(0xFF898989)),
                ),
                TextSpan(text: ' Into '),
                TextSpan(
                  text: 'Rhythm',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                TextSpan(text: ' And Bring It To The Stage.'),
              ],
            ),
            textAlign: centered ? TextAlign.center : TextAlign.left,
            style: const TextStyle(
              fontFamily: 'Space Grotesk',
              fontSize: 35,
              height: 1.43,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 40),
          Text.rich(
            const TextSpan(
              children: [
                TextSpan(text: 'We are '),
                TextSpan(
                  text: 'RÜFÜS DU SOL',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                TextSpan(
                  text: ' — an electronic band creating atmospheric rhythms '
                      'that move both body & heart. Our music lives where '
                      'emotion meets the dancefloor.',
                ),
              ],
            ),
            textAlign: centered ? TextAlign.center : TextAlign.justify,
            style: const TextStyle(
              fontFamily: 'Mulish',
              fontSize: 20,
              height: 2,
              fontWeight: FontWeight.w600,
              color: Color(0xFF898989),
            ),
          ),
        ],
      ),
    );
  }
}
