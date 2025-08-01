// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:profacademy/models/api_request.dart';
import 'package:profacademy/pages/home_screen.dart';
import 'package:profacademy/pages/sign_in_screen.dart';
import 'package:profacademy/shared/shared_colors.dart';
import 'package:profacademy/shared/text_style.dart';

class PendingScreen1 extends StatefulWidget {
  const PendingScreen1({super.key});

  @override
  State<PendingScreen1> createState() => _PendingScreen1State();
}

class _PendingScreen1State extends State<PendingScreen1> {
  final ApiRequest apiRequest = ApiRequest();
  Map<String, dynamic> allData = {};
  bool isLoading = true;

  createData() async {
    try {
      final data = await apiRequest.fecthData();
      if (!mounted) return;
      setState(() {
        allData = data;
        isLoading = false;
      });
    } on DioException catch (_) {
      if (!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false, // المستخدم لا يقدر يخرج من الديالوج
        builder: (context) {
          return AlertDialog(
            title: Text('فشل الاتصال'),
            content: Text('من فضلك تأكد من اتصالك بالإنترنت وحاول مجددًا.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // يقفل الديالوج
                  createData(); // إعادة المحاولة
                },
                child: Text('إعادة المحاولة'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    createData();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: bgColor,
        body: Center(
          child: CircularProgressIndicator(color: Colors.blue),
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            CircleAvatar(
              backgroundColor: Color.fromARGB(255, 5, 21, 87),
              radius: 30,
              child: Image.asset("assets/images/white 2.png", fit: BoxFit.fill),
            ),
            SizedBox(height: 30),
            Text(
              "مرحبا بك في Prof academy",
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 47,
                fontFamily: "prof",
                color: const Color.fromARGB(255, 80, 73, 10),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "رفيق الذكاء الاصطناعي لصحتك العقلية الواعية للجميع وفي أي مكان",
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontFamily: "prof",
                fontWeight: FontWeight.w100,
              ),
            ),
            SizedBox(height: 30),
            Image.asset("assets/images/ps1.png"),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  _createRoute(HomeScreen()),
                );
              },
              child: Container(
                height: 50,
                width: 105,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ابدأ",
                      style: textStyle.copyWith(color: Colors.white),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  },
                  child: Text(
                    "تسجيل الدخول",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "prof",
                      color: const Color.fromARGB(255, 255, 119, 0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "هل لديك حساب بالفعل؟ ",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "prof",
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
Route _createRoute(Widget child) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeOutCirc;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}
