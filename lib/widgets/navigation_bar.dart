// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:profacademy/shared/shared_colors.dart';

class customNavigationBar extends StatefulWidget {
  final int index;
  final Function(int) onTap;

  const customNavigationBar({super.key, required this.index, required this.onTap});

  @override
  State<customNavigationBar> createState() => _customNavigationBarState();
}

class _customNavigationBarState extends State<customNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor:const Color.fromARGB(255, 14, 50, 139),
      unselectedItemColor: const Color.fromARGB(255, 14, 50, 139),
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(color: blueBarColor),
      backgroundColor: blueBarColor,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "الحساب"),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_active),
          label: "الاشعارات",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: "الاختبارات"),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
      ],
      currentIndex: widget.index,
      onTap: widget.onTap,
    );
  }
}
