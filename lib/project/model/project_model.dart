import 'package:get/get.dart';

enum TaskType { todo, progress, done }

class ProjectModel {
  RxList<Task> todoList;
  RxList<Task> progressList;
  RxList<Task> doneList;
  String name;
  String description;
  DateTime createdAt;

  ProjectModel({
    required this.name,
    required this.createdAt,
    required this.description,
    RxList<Task>? todoList,
    RxList<Task>? progressList,
    RxList<Task>? doneList,
  })  : this.todoList = todoList ?? <Task>[].obs,
        this.progressList = progressList ?? <Task>[].obs,
        this.doneList = doneList ?? <Task>[].obs;
}

class Task {
  TaskType taskType;
  String name;
  String description;
  DateTime createdAt;
  RxList<Comment>? commentList;

  Task({
    required this.name,
    required this.createdAt,
    required this.taskType,
    RxList<Comment>? commentList,
    required this.description,
  }) : this.commentList = commentList ?? <Comment>[].obs;
}

class Comment {
  String name;
  DateTime createdAt;

  Comment({required this.name, required this.createdAt});
}
