import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ticketly/api/dio_client.dart';
import 'package:ticketly/cubit/dashboard/dashboard_cubit.dart';
import 'package:ticketly/cubit/dashboard/dashboard_state.dart';
import 'package:ticketly/models/api_response.dart';

class MockDioClient extends Mock implements DioClient {}

void main() {
  group('DashboardCubit', () {
    late MockDioClient mockDioClient;
    late DashboardCubit dashboardCubit;

    setUp(() {
      mockDioClient = MockDioClient();
      dashboardCubit = DashboardCubit(mockDioClient);
    });

    tearDown(() {
      dashboardCubit.close();
    });
    test('initial state - DashboardInitial', () {
      expect(dashboardCubit.state.runtimeType, DashboardInitial);
    });

    blocTest<DashboardCubit, DashboardState>(
      'emits [DashboardLoading, DashboardLoaded] when search is successful',
      build: () {
        final mockResponse = ApiResponse(
          version: '1.0',
          systemMessages: [],
          locations: [],
        );
        when(() => mockDioClient.fetchApiResponse(any()))
            .thenAnswer((_) async => mockResponse);
        return dashboardCubit;
      },
      act: (cubit) => cubit.search('test'),
      expect: () => [isA<DashboardLoading>(), isA<DashboardLoaded>()],
    );

    blocTest<DashboardCubit, DashboardState>(
      'emits [DashboardLoading, DashboardError] when search fails',
      build: () {
        when(() => mockDioClient.fetchApiResponse(any()))
            .thenThrow(Exception());
        return dashboardCubit;
      },
      act: (cubit) => cubit.search('test'),
      expect: () => [isA<DashboardLoading>(), isA<DashboardError>()],
    );
  });
}
