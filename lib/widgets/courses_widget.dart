// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:profacademy/pages/corses_screen.dart';

import 'package:profacademy/shared/text_style.dart';

Widget buildCoursesWidget(BuildContext context,String title,String price,String image,String description,Color color) {

  return Column(
    children: [
      Card(color:color,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Image.network(image ,fit: BoxFit.fill),
            Text(title, style: textStyle),
          Text(description, style: textStyle.copyWith(fontSize: 15,color: const Color.fromARGB(255, 126, 127, 129))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(price, style: textStyle.copyWith(fontSize: 15,color: Colors.green)),
                  Text(" | ", style: textStyle.copyWith(fontSize: 15)),
                  Text(
                    "ايهاب ابو العيون",
                    style: textStyle.copyWith(fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
