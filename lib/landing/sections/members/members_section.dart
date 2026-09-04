import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

part 'member_card.dart';

class MembersSection extends StatelessWidget {
  const MembersSection({super.key});

  static const _compactBreakpoint = 1280.0;
  static const _verticalBreakpoint = 768.0;

  static const _members = [
    _MemberData(
      name: 'Tyrone Lindqvist',
      role: 'Vocals, Guitar, Keyboards',
      imageAsset: 'assets/images/tyrone.png',
    ),
    _MemberData(
      name: 'Jon George',
      role: 'Keyboards',
      imageAsset: 'assets/images/jon.png',
    ),
    _MemberData(
      name: 'James Hunt',
      role: 'Drums',
      imageAsset: 'assets/images/james.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final useVerticalLayout = constraints.maxWidth <= _verticalBreakpoint;
        final compact = constraints.maxWidth <= _compactBreakpoint;

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1600),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: useVerticalLayout ? 24 : (compact ? 40 : 80),
                vertical: compact ? 50 : 70,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const _MembersBadge(),
                  const SizedBox(height: 30),
                  Text.rich(
                    const TextSpan(
                      children: [
                        TextSpan(text: 'This Is Where The '),
                        TextSpan(
                          text: 'Music',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        TextSpan(text: ' Begins'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Space Grotesk',
                      fontSize: compact ? 32 : 36,
                      height: 1.4,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: 148,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (useVerticalLayout)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (var index = 0;
                            index < _members.length;
                            index++) ...[
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 400),
                            child: SizedBox(
                              width: double.infinity,
                              height: 500,
                              child: _MemberCard(member: _members[index]),
                            ),
                          ),
                          if (index != _members.length - 1)
                            const SizedBox(height: 30),
                        ],
                      ],
                    )
                  else
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1220),
                      child: SizedBox(
                        height: compact ? 430 : 500,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            for (var index = 0;
                                index < _members.length;
                                index++) ...[
                              Expanded(
                                child: _MemberCard(
                                  member: _members[index],
                                  compact: compact,
                                ),
                              ),
                              if (index != _members.length - 1)
                                SizedBox(width: compact ? 20 : 40),
                            ],
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MembersBadge extends StatelessWidget {
  const _MembersBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(60),
      ),
      child: const Text(
        'Members',
        style: TextStyle(
          fontFamily: 'Gothic A1',
          fontSize: 22,
          height: 1,
          fontWeight: FontWeight.w300,
          color: Colors.black,
        ),
      ),
    );
  }
}
