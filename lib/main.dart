import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ticketly/api/dio_client.dart';
import 'package:ticketly/navigation/routes.dart';

void main() {
  Dio dio = Dio();
  DioClient dioClient = DioClient(dio: dio);
  RouteGenerator.dioClient = dioClient;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticket Hub',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
