import 'package:flutter/material.dart';
import 'package:profacademy/pages/sign_up_screen.dart';

class DontHaveAnAccountWidget extends StatelessWidget {
  const DontHaveAnAccountWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUpScreen(),
                ),
              )
            },
            child: const Text(
              'إنشاء حساب',
              style: TextStyle(
                  fontSize:20,
                  color: Color.fromARGB(255, 245, 228, 3),
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Text(
            ' ليس لديك حساب؟',
            style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold),
          ),
          
        ],
      ),
    );
  }
}
