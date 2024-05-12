import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_todo_app/model/task.dart';
import 'package:simple_todo_app/services/database.dart';

class AddTaskController extends GetxController {
  late DatabaseHelper dbHelper;
  final taskName = ''.obs;
  late TextEditingController textEditingController;

  @override
  void onInit() {
    super.onInit();
    dbHelper = DatabaseHelper();
    textEditingController = TextEditingController();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }

  Future<void> addTask() async {
    var task = Task(taskName: taskName.value);
    await dbHelper.insertTask(task);
    taskName.value = '';
    textEditingController.clear();
  }
}

class AddTaskPage extends StatelessWidget {
  final AddTaskController controller = Get.put(AddTaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Task',
          style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.w500),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Get.theme.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(result: "reload"),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Task Name", style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.w400),),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Get.theme.primaryColor, fontWeight: FontWeight.w400),
                    hintText: "Training at the Gym",
                    fillColor: Colors.white70,
                  ),
                  controller: controller.textEditingController,
                  onChanged: (value) => controller.taskName.value = value,
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.all(30),
            child: FractionallySizedBox(
              widthFactor: 1,
              child: Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Get.theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(6.0),
                    ),
                  ),
                  onPressed: () {
                    controller.addTask();
                  },
                  child:
                      const Text('Done', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
