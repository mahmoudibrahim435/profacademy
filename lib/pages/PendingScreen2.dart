// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:profacademy/pages/pendingScreen3.dart';
import 'package:profacademy/shared/shared_colors.dart';
import 'package:profacademy/shared/text_style.dart';

class PendingScreen2 extends StatefulWidget {
  const PendingScreen2({super.key});

  @override
  State<PendingScreen2> createState() => _PendingScreen2State();
}

class _PendingScreen2State extends State<PendingScreen2> {
  double progressValue = 0.3;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
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
                    "الخطوة الاولى",
                    style: textStyle.copyWith(color: Colors.brown),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: size.height * 0.61,
              child: Image.asset("assets/images/ps2.png"),
              
              
            ),
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
                Text(textDirection: TextDirection.rtl,
                  "عالم التميز ",
                  style: textStyle.copyWith(
                    color: const Color.fromARGB(255, 242, 144, 8),
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
            
                Text(textDirection: TextDirection.rtl,
                  "ادخل إلى ",
                  style: textStyle.copyWith(
                    color: const Color.fromARGB(255, 82, 40, 26),
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              
              ],
            ),
        Text(textDirection: TextDirection.rtl,
                  "في التعلم",
                  style: textStyle.copyWith(
                    color: const Color.fromARGB(255, 82, 40, 26),
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                            SizedBox(height: 30),

                GestureDetector(
              onTap: () {     Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => const Pendingscreen3()),
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
                  
                    Icon(Icons.arrow_forward, color: Colors.white,size: 35,),
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
