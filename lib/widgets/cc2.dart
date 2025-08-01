import 'package:flutter/material.dart';
import 'package:profacademy/shared/shared_colors.dart';

Widget cc2(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Card(
        color: blueBarColor,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          width: size.width * 0.4,
          height: size.height * 0.05,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.file_present_outlined, color: Colors.white,size: 20,),
                Text(
                  "الواجبات",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
        Card(
        color: blueBarColor,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          width: size.width * 0.4,
          height: size.height * 0.05,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.assignment_outlined, color: Colors.white,size: 20,),
                Text(
                  "الاختبارات",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
