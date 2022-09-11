import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:orange/main.dart' as app;
import 'package:orange/main.dart';
void main() {
  // enableFlutterDriverExtension();
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("Login Test", (WidgetTester tester) async {
    app.main();

    final Finder loginEmailField = find.byKey(Key('email_field'));
    final Finder loginPasswordField = find.byKey(Key('password_field'));
    final Finder loginConfirmPasswordField = find.byKey(Key('cpassword_field'));
    final Finder loginSaveButton = find.byKey(Key('login_button'));

    await tester.pumpWidget(OrangeApp());

    await tester.pumpAndSettle();

    await tester.tap(loginEmailField);
    await tester.enterText(loginEmailField, "orange@gmail.com");



    await tester.tap(loginPasswordField);
    await tester.enterText(loginPasswordField, "123456");

    await tester.tap(loginConfirmPasswordField);
    await tester.enterText(loginConfirmPasswordField, "123456");

    await tester.tap(loginSaveButton);
    print("button tapped");
    await tester.pumpAndSettle(Duration(seconds: 5));
    expect(
        find.byWidgetPredicate((widget) =>
        widget is Flushbar &&
            widget.message is Text &&
            (widget.message as Text).data!.startsWith("Login Successful!")),
        findsOneWidget);

    await tester.pumpAndSettle(Duration(seconds: 2));
  });

}