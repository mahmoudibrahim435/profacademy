// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:profacademy/models/api_request.dart';
import 'package:profacademy/pages/home_screen.dart';
import 'package:profacademy/pages/sign_in_screen.dart';

class LoginFunc {
  final Dio dio = Dio();
  Map<String, dynamic> myData = {};

  Future<Map<String, dynamic>> login(BuildContext context, String teacherCode, String studentCode, String deviceId) async {
    try {
      final response = await dio.post(
        '${Host.varHost}/api/student/login',
        data: {
          'teacherCode': teacherCode,
          'studentCode': studentCode,
          'deviceId': deviceId,
        },
      );
      myData = response.data;
      if (response.data['statusCode'] == 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(
          showCloseIcon: true,
          duration: Duration(seconds: 10),
          content: Text(response.data['msg']),
          backgroundColor: Colors.green,
        ));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
      if (myData['statusCode'] == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(myData['msg']), backgroundColor: Colors.green),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(myData['errMsg'] ?? 'حدث خطأ غير متوقع'),
            backgroundColor: const Color.fromARGB(255, 175, 76, 76),
          ),
        );
      }
      return myData = response.data;
    } on DioException catch (e) {
      String errorMessage = 'حدث خطأ غير متوقع';
      int? statusCode;

      if (e.response?.data is Map<String, dynamic>) {
        myData = e.response!.data;

        statusCode = myData['statusCode'] ?? 0;
        final String? serverMessage = myData['errMsg'];

         switch (statusCode) {
          case 401:
            errorMessage =
                serverMessage?.isNotEmpty == true
                    ? serverMessage!
                    : 'الرمز المدخل غير صحيح';
            break;

          case 404:
            errorMessage =
                serverMessage?.isNotEmpty == true
                    ? serverMessage!
                    : 'المدرس ده مش موجود!';
            break;

          case 500:
            errorMessage =
                serverMessage?.isNotEmpty == true
                    ? serverMessage!
                    : 'فيه مشكلة فـ السيرفر، جرب تاني.';
            break;
          case 403:
            errorMessage =
                serverMessage?.isNotEmpty == true
                    ? serverMessage!
                    : 'الحساب ده متوقف دلوقتي اتواصل مع الدعم يا ريس!';
            break;

          default:
            errorMessage =
                serverMessage?.isNotEmpty == true
                    ? serverMessage!
                    : 'حدث خطأ غير متوقع، برجاء المحاولة لاحقًا.';
        }
      } else {
        errorMessage = 'فشل الاتصال بالخادم';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: const Color.fromARGB(255, 175, 76, 76),
        ),
      );
      
      // Return error data or empty map
      return myData.isNotEmpty ? myData : {'error': errorMessage};
    }
  }
  
  Future<void> registration(BuildContext context, String name, String studentPhone, String guardianPhone, String grade, String deviceId,) async { {

        try {
      final response = await dio.post(
        '${Host.varHost}/api/student/register',
        data: {
              "name": name,
          "studentPhone": studentPhone,
          "guardianPhone": guardianPhone,
          "grade": grade,
          "teacherCode": Host.teacherCode,
          "deviceId": deviceId,
        },
      );
  

      if (response.data['statusCode'] == 201) {
        // حفظ البيانات في GlobalApiData إذا كانت متوفرة
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            showCloseIcon: true,
            duration: Duration(seconds: 1000),
            content: Text(response.data['msg'] ?? 'تم إنشاء الحساب بنجاح'),
            backgroundColor: Colors.green,
          ),
        );
      
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(builder: (context) => SignInScreen())
          );
        
      } else {
        // معالجة الحالات الأخرى
        final message = response.data['msg'] ?? response.data['errMsg'] ?? 'حدث خطأ غير متوقع';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.orange,
          ),
        );
      
    }} on DioException catch (e) {
      print('Registration error: ${e.toString()}');
      
      String errorMessage = 'حدث خطأ غير متوقع';
      int? statusCode;

      if (e.response?.data is Map<String, dynamic>) {
        final responseData = e.response!.data;
        statusCode = responseData['statusCode'] ?? 0;
        final String? serverMessage = responseData['errMsg'];

        switch (statusCode) {
          case 500:
            errorMessage = serverMessage?.isNotEmpty == true
                ? serverMessage!
                : 'البيانات دي متسجلة قبل كده يا نجم.';
            break;

          case 404:
            errorMessage = serverMessage?.isNotEmpty == true
                ? serverMessage!
                : 'المدرس ده مش موجود!';
            break;

          case 409:
            errorMessage = serverMessage?.isNotEmpty == true
                ? serverMessage!
                : 'فيه مشكلة فـ السيرفر، جرب تاني.';
            break;

          default:
            errorMessage = serverMessage?.isNotEmpty == true
                ? serverMessage!
                : 'حدث خطأ غير متوقع، برجاء المحاولة لاحقًا.';
        }
      } else {
        errorMessage = 'فشل الاتصال بالخادم';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: const Color.fromARGB(255, 175, 76, 76),
        ),
      );
    } catch (e) {
      print('Unexpected registration error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ غير متوقع: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } 
  }

}
}