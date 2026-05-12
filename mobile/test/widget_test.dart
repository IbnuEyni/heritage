import 'package:flutter_test/flutter_test.dart';
import 'package:heritage/main.dart';

void main() {
  testWidgets('HeritageApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const HeritageApp());
    expect(find.text('Kebena Heritage'), findsOneWidget);
  });
}
