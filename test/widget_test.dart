import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rufusdusol_website/app.dart';

void main() {
  testWidgets('shows desktop navigation and hero content', (tester) async {
    tester.view.physicalSize = const Size(1440, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const RufusDuSolApp());

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('About Us'), findsOneWidget);
    expect(find.text('Reach Out'), findsOneWidget);
    expect(find.textContaining('RÜFÜS DU SOL'), findsOneWidget);
    expect(find.text('Discover the Music'), findsOneWidget);
    expect(find.byIcon(Icons.menu), findsNothing);
  });

  testWidgets('opens and closes mobile navigation', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const RufusDuSolApp());

    expect(find.byIcon(Icons.menu), findsOneWidget);
    expect(find.text('About Us'), findsNothing);

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    expect(find.text('About Us'), findsOneWidget);
    expect(find.byIcon(Icons.close), findsOneWidget);

    await tester.tap(find.text('About Us'));
    await tester.pumpAndSettle();

    expect(find.text('About Us'), findsNothing);
    expect(find.byIcon(Icons.menu), findsOneWidget);
  });
}
