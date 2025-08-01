import 'package:flutter/material.dart';

class PageHeading extends StatelessWidget {
  final String title;
  const PageHeading({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Text(
          title,
          style: const TextStyle(
            color: Color.fromARGB(255, 9, 16, 50),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
