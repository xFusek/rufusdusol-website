import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rufusdusol_website/landing/sections/tickets/concert.dart';
import 'package:rufusdusol_website/landing/sections/tickets/concerts.dart';

part 'concert_row.dart';

class TicketsSection extends StatelessWidget {
  const TicketsSection({super.key});

  static const _compactBreakpoint = 1280.0;
  static const _mobileBreakpoint = 768.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth <= _compactBreakpoint;
        final isMobile = constraints.maxWidth <= _mobileBreakpoint;

        return ClipRect(
          child: Stack(
            children: [
              Positioned(
                top: isMobile ? 260 : 220,
                left: 0,
                right: 0,
                height: 655,
                child: IgnorePointer(
                  child: SvgPicture.asset(
                    'assets/images/soundvawe_background_vector.svg',
                    fit: BoxFit.fill,
                    semanticsLabel: 'Soundwave decoration',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : (compact ? 40 : 70),
                  vertical: compact ? 50 : 70,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1230),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const _TicketsHeader(),
                        SizedBox(height: compact ? 50 : 70),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (
                              var index = 0;
                              index < concerts.length;
                              index++
                            ) ...[
                              ConcertRow(
                                concert: concerts[index],
                                compact: compact,
                                isMobile: isMobile,
                              ),
                              if (index != concerts.length - 1)
                                SizedBox(height: isMobile ? 24 : 34),
                            ],
                          ],
                        ),
                      ],
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

class _TicketsHeader extends StatelessWidget {
  const _TicketsHeader();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth <= 1200;
        final isMobile = constraints.maxWidth <= 720;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(60),
              ),
              child: const Text(
                'Tickets',
                style: TextStyle(
                  fontFamily: 'Gothic A1',
                  fontSize: 22,
                  height: 1,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text.rich(
              const TextSpan(
                children: [
                  TextSpan(text: 'Upcoming '),
                  TextSpan(
                    text: 'Concerts',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFA3A3A3),
                    ),
                  ),
                  TextSpan(text: ' And Events'),
                ],
              ),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Space Grotesk',
                fontSize: isMobile ? 36 : (compact ? 44 : 58),
                height: isMobile ? 1.25 : 1.12,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Playing live, just how you like it',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Mulish',
                fontSize: 16,
                height: 2.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF898989),
              ),
            ),
          ],
        );
      },
    );
  }
}
