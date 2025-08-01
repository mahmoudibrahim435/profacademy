// ignore_for_file: deprecated_member_use


import 'package:flutter/material.dart';
import 'package:profacademy/models/courses_list.dart';
import 'package:profacademy/pages/account_sreen.dart';
import 'package:profacademy/pages/home_screen.dart';
import 'package:profacademy/pages/notification_screen.dart';
import 'package:profacademy/pages/test_screen.dart';
import 'package:profacademy/shared/text_style.dart';
import 'package:profacademy/widgets/cc2.dart';
import 'package:profacademy/widgets/courses_card.dart';
import 'package:profacademy/widgets/home_appbar.dart';
import 'package:profacademy/widgets/navigation_bar.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CorsesScreen extends StatefulWidget {
  const CorsesScreen({super.key});

  
  
  @override
  State<CorsesScreen> createState() => _CorsesScreenState();

}

class _CorsesScreenState extends State<CorsesScreen> {

  
  
int index = 0;
  void onTap(int index) {
    setState(() {
      switch (index) {
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TestScreen()),
          );
          break;
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AccountScreen()),
          );
          break;
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotificationsScreen()),
          );
          break;
      }
    });
  }
  

  static const String bgImagePath = "assets/images/bg.png";

  double progress = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildHomeAppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(bgImagePath, fit: BoxFit.cover),
              ),
              Positioned(
                left: 10,
                right: 10,
                top: 10,
                bottom: size.height * 0.73,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 237, 237, 237),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SizedBox(
                    height: size.height * 0.4,
                    child: InAppWebView(
                      initialUrlRequest: URLRequest(url: WebUri(VideoId.webUrl)),
                      initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                          mediaPlaybackRequiresUserGesture: false,
                          javaScriptEnabled: true,
                          useShouldOverrideUrlLoading: true,
                          useOnLoadResource: true,
                        ),
                      ),
                      onWebViewCreated: (InAppWebViewController controller) {
                      },
                      onProgressChanged: (
                        InAppWebViewController controller,
                        int progress,
                      ) {
                        setState(() {
                          this.progress = progress / 100;
                        });
                      },
                      onLoadStart: (
                        InAppWebViewController controller,
                        WebUri? url,
                      ) {
                        setState(() {
                          progress = 0;
                        });
                      },
                      onLoadStop: (
                        InAppWebViewController controller,
                        WebUri? url,
                      ) {
                        setState(() {
                          progress = 1.0;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 20,
                top: size.height * 0.29,
                child: Text("المحاضرة الاولى", style: textStyle),
              ),
              Positioned(
                right: 20,
                top: size.height * 0.33,
                child: Text(
                  "المحاضرة الاولى",
                  style: textStyle.copyWith(
                    fontSize: 15,
                    color: const Color.fromARGB(180, 0, 0, 0),
                  ),
                ),
              ),
              Positioned(left: 35, top: size.height * 0.4, child: cc2(context)),

              //courses list
              Positioned(
                left: 10,
                top: size.height * 0.5,
                child: SizedBox(
                  height: size.height * 0.5,
                  width: size.width - 20, // Add width constraint
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return CoursesCard(
                        coursesTitle: "الشهر الاول",
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: customNavigationBar(index:index , onTap:onTap,),
    );
  }
}
