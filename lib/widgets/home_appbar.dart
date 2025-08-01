import 'package:flutter/material.dart';
import 'package:profacademy/shared/shared_colors.dart';
import 'package:profacademy/shared/text_style.dart';

AppBar buildHomeAppBar() {
  return AppBar(
        backgroundColor:const Color.fromARGB(255, 255, 255, 255),
    // // ),
    leading: Padding(
      padding: const EdgeInsets.only(top: 13, left:14),
      child: CircleAvatar(
        backgroundColor: const Color.fromARGB(215, 186, 186, 196),
        child: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person_rounded,
              size: 27,
              color: Color.fromARGB(169, 0, 0, 0),
            ),
          ),
        ),
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "مرحبا,في دار ابن سينا",
          style: textStyle.copyWith(color: textColor),
        ),
      ),
    ],

  );
}
