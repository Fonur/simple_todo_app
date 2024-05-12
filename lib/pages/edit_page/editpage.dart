import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_todo_app/model/task.dart';
import 'package:simple_todo_app/services/database.dart';

class TaskController extends GetxController {
  dynamic argumentData = Get.arguments;

  late DatabaseHelper dbHelper;
  var taskName = ''.obs;
  late Task editTask;

  void updateTaskName(String newTaskName) {
    taskName.value = newTaskName;
  }

  void updateTask(taskID) {
    var task = Task(id: taskID, taskName: taskName.value);
    dbHelper.updateTask(task);
    Get.back(result: "reload");
  }

  @override
  void onInit() {
    super.onInit();
    dbHelper = DatabaseHelper();
    editTask = (argumentData[0] as Task);
    taskName.value = editTask.taskName;
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class EditTaskPage extends StatelessWidget {
  final TaskController controller = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Task',
          style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.w500),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Get.theme.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(result: "reload"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Task Name",
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9.0),
                ),
                filled: true,
                hintStyle: TextStyle(
                    color: Get.theme.primaryColor, fontWeight: FontWeight.w400),
                hintText: "",
                fillColor: Colors.white70,
              ),
              onChanged: (value) => controller.updateTaskName(value),
            ),
            Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.all(30),
              child: FractionallySizedBox(
                widthFactor: 1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Get.theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(6.0),
                    ),
                  ),
                  onPressed: () {
                    controller.updateTask(controller.editTask.id ?? 0);
                  },
                  child:
                      const Text('Save', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
