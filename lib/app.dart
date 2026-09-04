import 'package:flutter/material.dart';
import 'package:rufusdusol_website/landing/landing_page.dart';

class RufusDuSolApp extends StatelessWidget {
  const RufusDuSolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RÜFÜS DU SOL',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Mulish',
      ),
      home: const LandingPage(),
    );
  }
}
