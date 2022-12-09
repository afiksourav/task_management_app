
import 'package:get/get.dart';
import '../Database/db_helper.dart';
import '../models/task_model.dart';

class TaskController extends GetxController{

 @override
  void onReady(){
    super.onReady();
  }
  var taskList = <TaskModel>[].obs;

  Future<int> addTask({ TaskModel ? task})async{
    return await DBHelper.insert(task);
  }

void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new TaskModel.fromJson(data)).toList());
  }

 void delete(TaskModel task){
    var val= DBHelper.delete(task);
   getTasks();
 }

 void markTaskCompleted(int id)async{
 await DBHelper.update(id);
   getTasks();
 }

}