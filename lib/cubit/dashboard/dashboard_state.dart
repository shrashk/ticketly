import 'package:ticketly/models/api_response.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {
  final String message;
  DashboardInitial({this.message = "Please enter some keywords to get the results"});
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
