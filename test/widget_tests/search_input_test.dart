import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketly/widgets/search_input.dart';

void main() {
  group('SearchInput Widget Tests', () {
    testWidgets('opens keyboard when tapped', (WidgetTester tester) async {
      // Arrange
      final focusNode = FocusNode();
      // ignore: unused_local_variable
      String inputText = '';
      onChanged(String value) {
        inputText = value;
      }

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchInput(
              onChanged: onChanged,
              focusNode: focusNode,
            ),
          ),
        ),
      );

      // Tap on the TextField to give it focus
      await tester.tap(find.byType(TextField));
      await tester.pump();

    
      // Verify that the keyboard is open by checking for a specific widget
      expect(find.byType(EditableText), findsOneWidget);

      // Optional: You can also verify that the TextField has focus
      expect(focusNode.hasFocus, true);
    });
  });
}
