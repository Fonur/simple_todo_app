import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_todo_app/pages/home_page/homepage.dart';
import 'package:simple_todo_app/routes/pages.dart';
import 'package:simple_todo_app/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: appThemeData,
      home: MyHomePage(),
      initialRoute: Routes.INITIAL,
      getPages: AppPages.pages,
    );
  }
}
