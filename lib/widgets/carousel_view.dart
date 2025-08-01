import 'package:flutter/material.dart';
import 'package:profacademy/shared/text_style.dart';

CarouselView customCarouselView(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  List<Widget> children = [
    Container(
      height: 100,
      width: size.width * 1,
      color: Colors.blue,
      child: Stack(
        children: [
          Positioned.fill(child: Image.asset("assets/images/669.jpg", fit: BoxFit.cover)),
          Positioned(
top: size.height * 0.08,
            right: 10,
            child: Text(
              "خصم 25%\nخاص اليوم! \nاحصل على خصم على كل طلب دورة تدريبية\n !صالح لهذا اليوم فقط. استغل الفرصة",
              textAlign: TextAlign.end,
              style: textStyle.copyWith(color: Colors.white,),
            ),
          ),
        ],
      ),
    ),
    Container(
      height: 100,
      width: size.width * 1,
      color: Colors.blue,
      child: Stack(
        children: [
          Positioned.fill(child: Image.asset("assets/images/669.jpg", fit: BoxFit.cover)),
          Positioned(
top: size.height * 0.08,
            right: 10,
            child: Text(
              "خصم 25%\nخاص اليوم! \nاحصل على خصم على كل طلب دورة تدريبية\n !صالح لهذا اليوم فقط. استغل الفرصة",
              textAlign: TextAlign.end,
              style: textStyle.copyWith(color: Colors.white,),
            ),
          ),
        ],
      ),
    ),
    Container(
      height: 100,
      width: size.width * 1,
      color: Colors.blue,
      child: Stack(
        children: [
          Positioned.fill(child: Image.asset("assets/images/669.jpg", fit: BoxFit.cover)),
          Positioned(
top: size.height * 0.08,
            right: 10,
            child: Text(
              "خصم 25%\nخاص اليوم! \nاحصل على خصم على كل طلب دورة تدريبية\n !صالح لهذا اليوم فقط. استغل الفرصة",
              textAlign: TextAlign.end,
              style: textStyle.copyWith(color: Colors.white,),
            ),
          ),
        ],
      ),
    ),
    Container(
      height: 100,
      width: size.width * 1,
      color: Colors.blue,
      child: Stack(
        children: [
          Positioned.fill(child: Image.asset("assets/images/669.jpg", fit: BoxFit.cover)),
          Positioned(
top: size.height * 0.08,
            right: 10,
            child: Text(
              "خصم 25%\nخاص اليوم! \nاحصل على خصم على كل طلب دورة تدريبية\n !صالح لهذا اليوم فقط. استغل الفرصة",
              textAlign: TextAlign.end,
              style: textStyle.copyWith(color: Colors.white,),
            ),
          ),
        ],
      ),
    ),
  ];
  return CarouselView(
reverse: true,    
itemSnapping: true,
    elevation: 5,
    shrinkExtent: 10,
    itemExtent: 600,
    children: children,
  );
}
