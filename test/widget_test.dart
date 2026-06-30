import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/my_container.dart';

void main() {
  testWidgets('Dice roller shows button and responds to tap',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: MyContainer.yellowGreen(),
      ),
    ));

    expect(find.text('Roll the dice'), findsOneWidget);

    await tester.tap(find.text('Roll the dice'));
    await tester.pump();

    expect(find.text('Roll the dice'), findsOneWidget);
  });
}
