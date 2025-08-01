// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:profacademy/pages/home_screen.dart';
import 'package:profacademy/pages/notification_screen.dart';
import 'package:profacademy/pages/sign_in_screen.dart';
import 'package:profacademy/pages/sign_up_screen.dart';
import 'package:profacademy/shared/text_style.dart';

class Pendingscreen4 extends StatefulWidget {
  const Pendingscreen4({super.key});

  @override
  State<Pendingscreen4> createState() => _Pendingscreen4State();
}

class _Pendingscreen4State extends State<Pendingscreen4> {
  double progressValue = 0.9;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 222, 242, 255),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange, width: 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    "الخطوة الثالثة",
                    style: textStyle.copyWith(color: Colors.brown),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Image.asset("assets/images/ps4.jpg"),
            SizedBox(height: 30),
            Stack(
              children: [
                Container(
                  width: 100,
                  height: 10,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                      255,
                      222,
                      173,
                      156,
                    ), // الخلفية الفاتحة
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progressValue,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.brown, // اللون الغامق (المليان)
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textDirection: TextDirection.rtl,
                  "عبر ",
                  style: textStyle.copyWith(
                    color: const Color.fromARGB(255, 82, 40, 26),
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),

                Text(
                  textDirection: TextDirection.rtl,
                  "شهادة ",
                  style: textStyle.copyWith(
                    color: const Color.fromARGB(255, 255, 225, 0),
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                Text(
                  textDirection: TextDirection.rtl,
                  "الحصول على ",
                  style: textStyle.copyWith(
                    color: const Color.fromARGB(255, 82, 40, 26),
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(
                  textDirection: TextDirection.rtl,
                  "الإنترنت يجعلك سعيدًا ",
                  style: textStyle.copyWith(
                    color: const Color.fromARGB(255, 82, 40, 26),
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),

            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => SignUpScreen(),
                  
                    // SignUpScreen(),
                  ),
                );
              },
              child: Container(
                height: 70,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_forward, color: Colors.white, size: 35),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
