// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:profacademy/shared/text_style.dart';

Widget Social(BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 80),
        
        child: Row(
        
        children: [
          Text('تابعنا علي',style: textStyle.copyWith(fontSize: 20,fontWeight: FontWeight.bold),),
            ],),
      ),
      SizedBox(height: 10),
      Row(
        children: [
          Icon(Icons.facebook, color: Colors.blue, size: 45),
          SizedBox(width: 10),
          Image.asset('assets/icons/youtube.png',width: 40,height: 40,),
          SizedBox(width: 10),
        Image.asset('assets/icons/whatsapp.png',width: 40,height: 40,),
        SizedBox(width: 10),
        Image.asset('assets/icons/instagram.png',width: 40,height: 40,),
          SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 227, 225, 91),
            child: Icon(Icons.phone, size: 30, color: const Color.fromARGB(255, 255, 255, 255))),
        ],
      ),
    Padding(
        padding: const EdgeInsets.only(left: 70),
        
        child: Row(
        
        children: [
          Text('Prof Academy',style: textStyle.copyWith(fontSize: 15,fontWeight: FontWeight.bold),),
            ],),
      ),
    ]
  );
}
