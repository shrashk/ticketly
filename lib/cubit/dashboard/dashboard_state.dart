import 'package:ticketly/constants.dart';
import 'package:ticketly/models/api_response.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {
  final String message;
  DashboardInitial({this.message = AppStrings.enterKeywords});
}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final ApiResponse apiResponse;
  DashboardLoaded({required this.apiResponse});
}

class DashboardError extends DashboardState {
  final String errorMessage;
  DashboardError(this.errorMessage);
}
