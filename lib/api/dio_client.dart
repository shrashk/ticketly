import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:ticketly/models/api_response.dart';

class DioClient {
  final Dio dio;

  DioClient({required this.dio}) {
    dio
      ..options.baseUrl = 'https://mvvvip1.defas-fgi.de/mvv'
      ..options.connectTimeout = const Duration(seconds: 10)
      ..options.receiveTimeout = const Duration(seconds: 8)
      ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ));
  }

  

  // Fetch API Response
  Future<ApiResponse> fetchApiResponse(String keyword) async {
    try {
      debugPrint("////////////critical how is this ??");
      final response = await dio.get("/XML_STOPFINDER_REQUEST?language=de&outputFormat=RapidJSON&coordOutputFormat=WGS84[DD:ddddd]&type_sf=any&name_sf=$keyword");
      if (response.statusCode == 200) {
        return ApiResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      rethrow;
    }
  }
}
