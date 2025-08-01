import 'package:flutter/material.dart';
import 'package:profacademy/models/courses_list.dart';

class CoursesCard extends StatelessWidget {
  final String coursesTitle;

  const CoursesCard({super.key, required this.coursesTitle});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Card(
          color: const Color.fromARGB(219, 26, 97, 198),
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  children: [
                    SizedBox(
                      width: size.width * 0.25,
                      height: size.height * 0.022,
                    
                      child: Center(
                        child: Text(
                          coursesTitle,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.25,
                      height: size.height * 0.05,
                    
                      child: Center(
                        child: Text(
                          coursesTitle,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: const Color.fromARGB(255, 82, 81, 81),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: size.width * 0.3,
                height: size.height * 0.09,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color.fromARGB(255, 255, 255, 255), width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                  "https://img.youtube.com/vi/${VideoId.VIDEO_ID}/maxresdefault.jpg",
                    alignment: Alignment.center,
                    fit: BoxFit.cover, 
                    
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
