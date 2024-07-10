import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketly/api/dio_client.dart';
import 'package:ticketly/cubit/dashboard/dashboard_cubit.dart';
import 'package:ticketly/cubit/dashboard/dashboard_screen.dart';

class RouteGenerator {
  static DioClient? dioClient;
  static Route<dynamic> generateRoute(RouteSettings settings) {
    debugPrint("Route: ${settings.name}");

    switch (settings.name) {
      case DashboardScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => DashboardCubit(dioClient!),
            child: const DashboardScreen(),
          ),
          settings: settings,
        );

      default:
        return MaterialPageRoute(builder: (_) => Scaffold(body: Center(child: Text('No route defined for ${settings.name}'))));
    }
  }
}
