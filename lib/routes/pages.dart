import 'package:get/get.dart';
import 'package:simple_todo_app/pages/add_page/addpage.dart';
import 'package:simple_todo_app/pages/edit_page/editpage.dart';
import 'package:simple_todo_app/pages/home_page/homepage.dart';
part './routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.INITIAL, page:()=> MyHomePage(),),
    GetPage(name: Routes.ADD, page:()=> AddTaskPage(),),
    GetPage(name: Routes.EDIT, page:() => EditTaskPage())
  ];
}