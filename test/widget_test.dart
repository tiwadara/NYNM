import 'package:resolution/src/app.dart';

void main() {
  var app = App();

  // **************  WIDGET  TESTS ***********************

  // Default State
//   testWidgets('Renders', (WidgetTester tester) async {
//     await tester.pumpWidget(app);
//
//     expect(find.text('Register'), findsOneWidget);
//     expect(find.text('I agree to the Terms of Services and Privacy Policy'),
//         findsOneWidget);
//     expect(find.byType(TextFormField), findsNWidgets(2));
//     expect(find.byType(OutlineButton), findsOneWidget);
//     expect(find.byType(Checkbox), findsOneWidget);
//   });
//
//   // Submitted
//   testWidgets('Form can be submitted', (WidgetTester tester) async {
//     await tester.pumpWidget(app);
//     final Finder nickname = find.widgetWithText(TextFormField, 'Nickname');
//     final Finder fullName = find.widgetWithText(TextFormField, 'Full name');
//     final Finder submit = find.widgetWithText(OutlineButton, 'Register');
//
//     expect(find.text('Form submitted'), findsNothing);
//
//     await tester.enterText(nickname, 'Jess');
//     await tester.enterText(fullName, 'Jess Sampson');
//
//     await tester.tap(submit);
//     await tester.pump();
//
//     expect(find.text('Form submitted'), findsOneWidget);
//   });
//
// // Required fields
//   testWidgets('Form requires nickname', (WidgetTester tester) async {
//     await tester.pumpWidget(app);
//     final Finder submit = find.widgetWithText(OutlineButton, 'Register');
//     await tester.tap(submit);
//     await tester.pump();
//
//     expect(find.text('Nickname is required'), findsOneWidget);
//     expect(find.text('Form submitted'), findsNothing);
//   });
//
//   // Check sumbmit disabled when required missing
//   testWidgets('Submit disabled if TOS unchecked', (WidgetTester tester) async {
//     await tester.pumpWidget(app);
//     final Finder submit = find.widgetWithText(OutlineButton, 'Register');
//     final Finder tos = find.byType(Checkbox);
//
//     expect(tester.widget<OutlineButton>(submit).enabled, isTrue);
//
//     await tester.tap(tos);
//     await tester.tap(submit);
//     await tester.pump();
//
//     expect(tester.widget<OutlineButton>(submit).enabled, isFalse);
//     expect(find.text('Form submitted'), findsNothing);
//   });
}
