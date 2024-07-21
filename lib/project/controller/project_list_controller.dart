import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kanban_task/project/model/project_model.dart';
import 'package:kanban_task/utils/app_colors.dart';
import 'package:kanban_task/widget/app_snackbar.dart';

class ProjectListController extends GetxController {
  RxList<ProjectModel> projectDataList = <ProjectModel>[].obs;

  TextEditingController projectNameController = TextEditingController();
  TextEditingController projectDesController = TextEditingController();
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  Rx<Task> draggedTask = Task(
          name: "",
          createdAt: DateTime.now(),
          taskType: TaskType.todo,
          description: "")
      .obs;

  Rx<Task> selectedTask = Task(
          name: "",
          createdAt: DateTime.now(),
          taskType: TaskType.todo,
          description: "")
      .obs;

  Rx<ProjectModel> selectedProject =
      ProjectModel(name: '', createdAt: DateTime.now(), description: '').obs;

  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('HH:mm dd-MM-yyyy');
    return formatter.format(dateTime);
  }

  void addTask(
    int index,
    TaskType type,
  ) {
    if (taskNameController.text.isEmpty) {
      AppSnackBar.showSnackBarAtTop(
          message: "please enter task name",
          color: Colors.red.shade400,
          title: "Error");
    } else {
      if (type == TaskType.todo) {
        projectDataList[index].todoList.add(Task(
            name: taskNameController.text,
            createdAt: DateTime.now(),
            taskType: TaskType.todo,
            description: taskDescriptionController.text));
        projectDataList.refresh();
        projectDataList[index].todoList.refresh();
        taskNameController.clear();
        taskDescriptionController.clear();
        Get.back();

        AppSnackBar.showSnackBarAtTop(
            message: "Task added successfully!!",
            color: Colors.green.shade400,
            title: "Success");
      } else if (type == TaskType.progress) {
        projectDataList[index].progressList.add(Task(
            name: taskNameController.text,
            createdAt: DateTime.now(),
            taskType: TaskType.todo,
            description: taskDescriptionController.text));
        projectDataList.refresh();
        projectDataList[index].progressList.refresh();
        taskNameController.clear();
        taskDescriptionController.clear();
        Get.back();

        AppSnackBar.showSnackBarAtTop(
            message: "Task added successfully!!",
            color: Colors.green.shade400,
            title: "Success");
      } else {
        projectDataList[index].doneList.add(Task(
            name: taskNameController.text,
            createdAt: DateTime.now(),
            taskType: TaskType.todo,
            description: taskDescriptionController.text));
        projectDataList.refresh();
        projectDataList[index].doneList.refresh();
        taskNameController.clear();
        taskDescriptionController.clear();
        Get.back();

        AppSnackBar.showSnackBarAtTop(
            message: "Task added successfully!!",
            color: Colors.green.shade400,
            title: "Success");
      }
    }
  }

  void editTask(int index, TaskType type) {
    if (taskNameController.text.isEmpty) {
      AppSnackBar.showSnackBarAtTop(
          message: "please enter task name",
          color: Colors.red.shade400,
          title: "Error");
    } else {
      if (type == TaskType.todo) {
        projectDataList[index].todoList[index] = Task(
            name: taskNameController.text,
            createdAt: DateTime.now(),
            taskType: TaskType.todo,
            description: taskDescriptionController.text);
        projectDataList.refresh();
        projectDataList[index].todoList.refresh();
        taskNameController.clear();
        taskDescriptionController.clear();
        Get.back();

        AppSnackBar.showSnackBarAtTop(
            message: "Task added successfully!!",
            color: Colors.green.shade400,
            title: "Success");
      } else if (type == TaskType.progress) {
        projectDataList[index].progressList.add(Task(
            name: taskNameController.text,
            createdAt: DateTime.now(),
            taskType: TaskType.todo,
            description: taskDescriptionController.text));
        projectDataList.refresh();
        projectDataList[index].progressList.refresh();
        taskNameController.clear();
        taskDescriptionController.clear();
        Get.back();

        AppSnackBar.showSnackBarAtTop(
            message: "Task added successfully!!",
            color: Colors.green.shade400,
            title: "Success");
      } else {
        projectDataList[index].doneList.add(Task(
            name: taskNameController.text,
            createdAt: DateTime.now(),
            taskType: TaskType.todo,
            description: taskDescriptionController.text));
        projectDataList.refresh();
        projectDataList[index].doneList.refresh();
        taskNameController.clear();
        taskDescriptionController.clear();
        Get.back();

        AppSnackBar.showSnackBarAtTop(
            message: "Task added successfully!!",
            color: Colors.green.shade400,
            title: "Success");
      }
    }
  }

  // Update task list logic
  void updateTaskList(
      int projectIndex, List<Task> updatedTaskList, String title) {
    if (title == "To-Do") {
      projectDataList[projectIndex].todoList.value = updatedTaskList;
      projectDataList[projectIndex].todoList.refresh();
    } else if (title == "In Progress") {
      projectDataList[projectIndex].progressList.value = updatedTaskList;
      projectDataList[projectIndex].progressList.refresh();
    } else if (title == "Done") {
      projectDataList[projectIndex].doneList.value = updatedTaskList;
      projectDataList[projectIndex].doneList.refresh();
    }
    projectDataList.refresh();
  }

 }
