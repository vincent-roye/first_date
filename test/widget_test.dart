import 'package:flutter_test/flutter_test.dart';
import 'package:first_date/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const FirstDateApp());
    expect(find.text('First Date'), findsOneWidget);
  });
}
