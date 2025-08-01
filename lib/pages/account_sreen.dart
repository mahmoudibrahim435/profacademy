// lib/main.dart
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ProfileScreen());
  }
}

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تفاصيل الاختيار')),
      // body: FutureBuilder<ProfileModel>(
      //   // future: apiService.fetchData(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(child: CircularProgressIndicator());
      //     } else if (snapshot.hasError) {
      //       return Center(child: Text('Error: ${snapshot.error}'));
      //     } else {
      //       final data = snapshot.data!;
      //       return Padding(
      //         padding: const EdgeInsets.all(16.0),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text(
      //               data.name,
      //               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      //             ),
      //             SizedBox(height: 10),
      //             Text('مدرس: ${data.teacherName}'),
      //             Text('درجة: ${data.grade}'),
      //             Text('تاريخ انتهاء: ${data.expiryDate}'),
      //           ],
      //         ),
      //       );
      //     }
      //   },
      // ),
    );
  }
}
