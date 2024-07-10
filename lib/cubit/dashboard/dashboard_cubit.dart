import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketly/api/dio_client.dart';
import 'package:ticketly/constants.dart';
import 'package:ticketly/cubit/dashboard/dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DioClient dioClient;
  DashboardCubit(this.dioClient) : super(DashboardInitial());

  Future<void> search(String keywords) async {
    emit(DashboardLoading());
    try {
      var response = await dioClient.fetchApiResponse(keywords);
      emit(DashboardLoaded(apiResponse: response));
    } catch (error) {
      emit(DashboardError(AppStrings.errorOccurred));
    }
  }
}
