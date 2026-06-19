// Basic Flutter widget test.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medclinic_app/main.dart';

void main() {
  testWidgets('App launches and shows MainNavigation', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const ClinicApp());
    await tester.pumpAndSettle();

    // Verify that MainNavigation appears.
    expect(find.byType(MainNavigation), findsOneWidget);
    // Verify a bottom navigation item exists.
    expect(find.byIcon(Icons.home_rounded), findsOneWidget);
  });
}
