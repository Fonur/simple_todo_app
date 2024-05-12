import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_todo_app/model/task.dart';
import 'package:simple_todo_app/pages/add_page/addpage.dart';
import 'package:simple_todo_app/pages/edit_page/editpage.dart';
import 'package:simple_todo_app/services/database.dart';

import '../../routes/pages.dart';

class HomePageController extends GetxController {
  late DatabaseHelper dbHelper;
  RxList<Task> tasks = <Task>[].obs;

  void toggleTaskDone(Task task) {
    task.done = !task.done;
    tasks.refresh();
    dbHelper.updateTask(task);
  }

  Future<void> goEditPage(Task task) async {
    final goEdit = await Get.toNamed(Routes.EDIT, arguments: [task]);
    if (goEdit == "reload") {
      loadTasks();
    }
  }

  Future<void> goAddPage() async {
    final goAdd = await Get.toNamed(Routes.ADD);
    if (goAdd == "reload") {
      loadTasks();
    }
  }

  void loadTasks() async {
    final taskList = await dbHelper.tasks();
    tasks.assignAll(taskList);
  }

  @override
  void onInit() {
    super.onInit();
    dbHelper = DatabaseHelper();
    loadTasks();
  }

  @override
  void onReady() {
    super.onReady();
    loadTasks();
  }
}

class MyHomePage extends StatelessWidget {
  final HomePageController controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: Get.theme.primaryColor,
        title: Container(
          padding: EdgeInsets.only(top: 5),
          height: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Image.asset(
                  "assets/images/image.png",
                  width: 50,
                  height: 50,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello, FİKRET",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: Get.width * 0.6,
                    child: Text(
                      "fikretonurozdil@gmail.com",
                      style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w100,
                          fontSize: 25.0),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Get.theme.hintColor,
                border: BorderDirectional(
                  bottom: BorderSide(
                    width: 2,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
              height: 150,
              width: Get.width * 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                    child: Transform.scale(
                      scale: 0.6,
                      child: Image.asset("assets/images/victory.png"),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                        child: Text(
                          "Go Pro (No Ads)",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16.0),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          "No fuss, no ads, for only \$1 a month",
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: SizedBox()),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    width: 75,
                    height: 75,
                    color: Get.theme.primaryColorDark,
                    child: Center(
                      child: Text(
                        "\$1",
                        style: TextStyle(
                            color: Color(0xFFF2C94C),
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.tasks.length,
                itemBuilder: (context, index) {
                  final task = controller.tasks[index];
                  return Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(0, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            onChanged: (bool? checked) {
                              if (checked != null) {
                                controller
                                    .toggleTaskDone(controller.tasks[index]);
                              }
                            },
                            checkColor: Get.theme.focusColor,
                            activeColor: Get.theme.splashColor,
                            value: task.done,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        Text(
                          task.taskName,
                          style: TextStyle(
                              color: Get.theme.primaryColorDark,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        ),
                        Expanded(child: SizedBox()),
                        InkWell(
                          onTap: () =>
                              {controller.goEditPage(controller.tasks[index])},
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              border: Border.all(
                                color: Get.theme.primaryColorDark,
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                'Edit',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Get.theme.primaryColorDark,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: Get.theme.primaryColorDark,
                width: 2,
                style: BorderStyle.solid)),
        child: FloatingActionButton(
          onPressed: controller.goAddPage,
          tooltip: 'Add Task',
          child: const Icon(Icons.add, color: Colors.white),
          backgroundColor: Get.theme.primaryColor,
          shape: CircleBorder(),
        ),
      ),
    );
  }
}
