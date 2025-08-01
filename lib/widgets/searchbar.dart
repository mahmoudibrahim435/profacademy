import 'package:flutter/material.dart';
import 'package:profacademy/shared/text_style.dart';

SearchBar buildSearchBar() {
  return SearchBar(
    shape:WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))) ,
    leading: IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.search_rounded,
        size: 40,
        color: const Color.fromARGB(159, 131, 123, 123),
      ),
    ),
    hintText: "ابحث",
    hintStyle: WidgetStatePropertyAll(
      textStyle.copyWith(color: Colors.grey),
    ),
    elevation: WidgetStatePropertyAll(4),
    backgroundColor: WidgetStatePropertyAll(
      const Color.fromARGB(214, 255, 255, 255),
    ),
  );
}