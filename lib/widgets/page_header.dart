import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.3,
      child: Image.asset('assets/images/black 2.png'),
    );
  }
}
