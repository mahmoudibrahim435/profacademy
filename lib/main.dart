
import 'package:flutter/material.dart';
import 'package:profacademy/pages/splashscreen.dart';

void main() {
  runApp(
  const MyApp(),
  // WidgetsFlutterBinding.ensureInitialized();
  );
}

 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: const Splashscreen(),
    );
  }
}