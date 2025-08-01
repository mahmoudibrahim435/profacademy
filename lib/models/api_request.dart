import 'package:dio/dio.dart';

class ApiRequest {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> fecthData() async {
    try {
      final response = await _dio.get('${Host.varHost}/api/get-initial-data',
          options: Options(headers: {'Accept': 'application/json'}),
          data: {"teacherCode": Host.teacherCode});

      print(response.data);
      return response.data;
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          throw Exception("Connection Timeout");
        default:
          throw Exception(e.toString());
          
      }
    }
  }
}

class Host {
  static String varHost = "https://prof-academy.vercel.app";
  static String teacherCode = '48232300';
}
// "https://prof-academy.vercel.app"        "teacherCode" : "48232300"
