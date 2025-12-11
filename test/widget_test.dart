import 'package:flutter_test/flutter_test.dart';
import 'package:municipality_mvp/main.dart';

void main() {
  testWidgets('App renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MunicipalityApp());
    await tester.pumpAndSettle();
    
    // Verify app renders
    expect(find.text('Good Morning'), findsOneWidget);
  });
}
