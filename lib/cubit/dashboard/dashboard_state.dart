import 'package:equatable/equatable.dart';
import 'package:ticketly/constants.dart';
import 'package:ticketly/models/api_response.dart';

abstract class DashboardState extends Equatable {}

class DashboardInitial extends DashboardState {
  final String message;
  DashboardInitial({this.message = AppStrings.enterKeywords});
  @override
  List<Object> get props => [];
}

class DashboardLoading extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardLoaded extends DashboardState {
  final ApiResponse apiResponse;
  final String textInSearch;
  DashboardLoaded({required this.apiResponse, this.textInSearch = ""});
  @override
  List<Object> get props => [apiResponse, textInSearch];

  //create copywith method to update the textInSearch
  DashboardLoaded copyWith({ApiResponse? apiResponse, String? textInSearch}) {
    return DashboardLoaded(
      apiResponse: apiResponse ?? this.apiResponse,
      textInSearch: textInSearch ?? this.textInSearch,
    );
  }
}

class DashboardError extends DashboardState {
  final String errorMessage;
  DashboardError(this.errorMessage);
  @override
  List<Object> get props => [];
}
