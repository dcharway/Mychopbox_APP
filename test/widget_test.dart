import 'package:flutter_test/flutter_test.dart';

import 'package:mychopbox_app/main.dart';

void main() {
  testWidgets('App renders SHS Supplies home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyChopBoxApp());

    expect(find.text('SHS Supplies'), findsOneWidget);
  });
}
