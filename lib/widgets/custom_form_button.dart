import 'package:flutter/material.dart';

class CustomFormButton extends StatelessWidget {
  final String innerText;
  final void Function()? onPressed;
  const CustomFormButton(
      {super.key, required this.innerText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: size.height * 0.05,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                innerText,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              right: size.height * 0.01,
              top: size.height * 0.006,
              child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: const Icon(Icons.arrow_forward,
                      color: Colors.blue, size: 35)),
            ),
          ],
        ),
      ),
    );
  }
}
