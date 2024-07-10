import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ticketly/api/dio_client.dart';
import 'package:ticketly/constants.dart';
import 'package:ticketly/cubit/dashboard/dashboard_cubit.dart';
import 'package:ticketly/cubit/dashboard/dashboard_screen.dart';
import 'package:ticketly/cubit/dashboard/dashboard_state.dart';
import 'package:ticketly/models/api_response.dart';

// Mock DioClient for testing purposes
class MockDioClient extends Mock implements DioClient {}

void main() {
  group('Dashboard Integration Test', () {
    late MockDioClient mockDioClient;
    late DashboardCubit dashboardCubit;

    setUp(() {
      mockDioClient = MockDioClient();
      dashboardCubit = DashboardCubit(mockDioClient);
    });

    testWidgets('Dashboard screen shows loading indicator and list on success',
        (WidgetTester tester) async {
      // Mock successful response -- future enhancement create mock-response separately
      final mockResponse = ApiResponse(
        version: '1.0',
        systemMessages: [],
        locations: [
          Location(
              id: "id",
              name: "name",
              coord: [1.0],
              type: 'type',
              matchQuality: 123,
              isBest: true,
              parent: Parent(id: "id", name: "name", type: "type"))
        ],
      );
      when(() => mockDioClient.fetchApiResponse(any())).thenAnswer((_) async {
        //delay is introduced to check if circularprogress indicator is shown
        await Future.delayed(const Duration(seconds: 2));
        return mockResponse;
      });

      await tester.pumpWidget(MaterialApp(
        initialRoute: '/',
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: dashboardCubit,
              child: const DashboardScreen(),
            ),
            settings: settings,
          );
        },
      ));
      expect(find.text(AppStrings.enterKeywords), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'ab');

      // Wait for debounce timer (800ms) to complete - we have search delay
      await tester.pump(const Duration(milliseconds: 800));

      // Check that the circular progress indicator is shown
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait for the delay to complete and the state to update
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();
      // Verify the type of the response in the cubit state
      final state = dashboardCubit.state;
      expect(state, isA<DashboardLoaded>());
      final loadedState = state as DashboardLoaded;
      expect(loadedState.apiResponse, isA<ApiResponse>());

      expect(find.byType(ListView), findsOneWidget);

      verify(() => mockDioClient.fetchApiResponse(any())).called(1);
    });

    testWidgets('Dashboard screen shows error', (WidgetTester tester) async {
      when(() => mockDioClient.fetchApiResponse(any())).thenThrow((_) async {
        return Exception();
      });

      await tester.pumpWidget(MaterialApp(
        initialRoute: '/',
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: dashboardCubit,
              child: const DashboardScreen(),
            ),
            settings: settings,
          );
        },
      ));
      expect(find.text(AppStrings.enterKeywords), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'ab');

      // Wait for debounce timer (800ms) to complete - we have search delay
      await tester.pump(const Duration(milliseconds: 800));

      await tester.pumpAndSettle();
      // Verify the type of the response in the cubit state
      final state = dashboardCubit.state;
      expect(state, isA<DashboardError>());

      verify(() => mockDioClient.fetchApiResponse(any())).called(1);
    });
  });
}
