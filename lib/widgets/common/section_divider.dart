import 'package:flutter/material.dart';

class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: double.infinity,
          height: constraints.maxWidth <= 768 ? 45 : 70,
          child: const ColoredBox(color: Color(0xFF898989)),
        );
      },
    );
  }
}
