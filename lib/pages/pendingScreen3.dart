// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:profacademy/pages/pending_screen4.dart';
import 'package:profacademy/shared/text_style.dart';

class Pendingscreen3 extends StatefulWidget {
  const Pendingscreen3({super.key});

  @override
  State<Pendingscreen3> createState() => _Pendingscreen3State();
}

class _Pendingscreen3State extends State<Pendingscreen3> {
  double progressValue = 0.6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 217, 235, 255),
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
                    "الخطوة الثانية",
                    style: textStyle.copyWith(color: Colors.brown),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Image.asset("assets/images/ps3.jpg"),
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
                  "تعلم في أي وقت",
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
                  Text(textDirection: TextDirection.rtl,
                  "عبر الإنترنت",
                  style: textStyle.copyWith(
                    color: const Color.fromARGB(255, 242, 144, 8),
                    fontWeight: FontWeight.bold,
                    fontSize: 37,
                  ),
                ),
                Text(
                  textDirection: TextDirection.rtl,
                  "تقديم دروس ",
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
              onTap: () {   Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => const Pendingscreen4()),
  );},
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
