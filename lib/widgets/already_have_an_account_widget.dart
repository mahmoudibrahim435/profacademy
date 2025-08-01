import 'package:flutter/material.dart';
import 'package:profacademy/pages/sign_in_screen.dart';

class AlreadyHaveAnAccountWidget extends StatelessWidget {
  const AlreadyHaveAnAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen())),
            child: const Text(
              'تسجيل الدخول',
              style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 245, 228, 3),
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Text(
            ' لديك حساب بالفعل؟',
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
