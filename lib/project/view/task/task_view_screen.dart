import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kanban_task/project/controller/project_list_controller.dart';
import 'package:kanban_task/project/model/project_model.dart';
import 'package:kanban_task/project/view/task/task_add_screen.dart';
import 'package:kanban_task/project/view/task/task_details_screen.dart';
import 'package:kanban_task/utils/app_colors.dart';
import 'package:kanban_task/widget/common_text.dart';

class TaskViewScreen extends StatelessWidget {
  TaskViewScreen({
    Key? key,
  }) : super(key: key);

  ProjectListController projectListController = Get.find();

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectListController>(initState: (state) {
      if (Get.arguments != null) {
        projectListController.selectedProject.value = Get.arguments["project"];
        index = Get.arguments["index"];
      }

      projectListController.selectedProject.refresh();
    }, builder: (context) {
      return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          toolbarHeight: 45.h,
          backgroundColor: AppColors.primaryColor,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.arrow_back_ios_new_rounded,
                    color: AppColors.white, size: 20.sp),
              ),
              10.w.horizontalSpace,
              CommonText(
                text: projectListController.selectedProject.value.name,
                fontSize: 20.sp,
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            DragTarget<Task>(onAccept: (task) {
              // Prevent duplicates by checking if the task already exists in the target list
              if (!projectListController.projectDataList[index].todoList
                  .contains(task)) {
                projectListController.projectDataList[index].todoList.add(task);
              }
              projectListController.projectDataList[index].progressList
                  .remove(task);
              projectListController.projectDataList[index].doneList
                  .remove(task);

              projectListController.projectDataList[index].todoList.refresh();
              projectListController.projectDataList[index].progressList
                  .refresh();
              projectListController.projectDataList[index].doneList.refresh();
            }, builder: (context, candidateData, rejectedData) {
              return Obx(() {
                return taskViewCard(
                  taskType: TaskType.todo,
                    onDragStarted: (task) {
                      projectListController.draggedTask.value = task;
                      projectListController.draggedTask.refresh();
                    },
                    onDragCompleted: () {
                      projectListController.draggedTask.value = Task(
                          name: "",
                          createdAt: DateTime.now(),
                          taskType: TaskType.todo,
                          description: "");
                      projectListController.draggedTask.refresh();
                    },
                    title: "To-Do",
                    taskList:
                        projectListController.projectDataList[index].todoList,
                    onPressedNew: () {
                      Get.to(() => TaskAddScreen(),
                          arguments: {"index": index, "type": TaskType.todo});
                    });
              });
            }),
            14.w.horizontalSpace,
            DragTarget<Task>(onAccept: (task) {
              // Prevent duplicates by checking if the task already exists in the target list
              if (!projectListController.projectDataList[index].progressList
                  .contains(task)) {
                projectListController.projectDataList[index].progressList
                    .add(task);
              }
              projectListController.projectDataList[index].todoList
                  .remove(task);
              projectListController.projectDataList[index].doneList
                  .remove(task);

              projectListController.projectDataList[index].todoList.refresh();
              projectListController.projectDataList[index].progressList
                  .refresh();
              projectListController.projectDataList[index].doneList.refresh();
            }, builder: (context, candidateData, rejectedData) {
              return Obx(() {
                return taskViewCard(
                  taskType: TaskType.progress,
                    onDragStarted: (task) {
                      projectListController.draggedTask.value = task;
                      projectListController.draggedTask.refresh();
                    },
                    onDragCompleted: () {
                      projectListController.draggedTask.value = Task(
                          name: "",
                          createdAt: DateTime.now(),
                          taskType: TaskType.todo,
                          description: "");
                      projectListController.draggedTask.refresh();
                    },
                    title: "In Progress",
                    taskList: projectListController
                        .projectDataList[index].progressList,
                    onPressedNew: () {
                      Get.to(() => TaskAddScreen(), arguments: {
                        "index": index,
                        "type": TaskType.progress
                      });
                    });
              });
            }),
            14.w.horizontalSpace,
            DragTarget<Task>(onAccept: (task) {
              // Prevent duplicates by checking if the task already exists in the target list
              if (!projectListController.projectDataList[index].doneList
                  .contains(task)) {
                projectListController.projectDataList[index].doneList.add(task);
              }
              projectListController.projectDataList[index].progressList
                  .remove(task);
              projectListController.projectDataList[index].todoList
                  .remove(task);

              projectListController.projectDataList[index].todoList.refresh();
              projectListController.projectDataList[index].progressList
                  .refresh();
              projectListController.projectDataList[index].doneList.refresh();
            }, builder: (context, candidateData, rejectedData) {
              return Obx(() {
                return taskViewCard(
                  taskType: TaskType.done,
                    onDragStarted: (task) {
                      projectListController.draggedTask.value = task;
                      projectListController.draggedTask.refresh();
                    },
                    onDragCompleted: () {
                      projectListController.draggedTask.value = Task(
                          name: "",
                          createdAt: DateTime.now(),
                          taskType: TaskType.todo,
                          description: "");
                      projectListController.draggedTask.refresh();
                    },
                    title: "Done",
                    taskList:
                        projectListController.projectDataList[index].doneList,
                    onPressedNew: () {
                      Get.to(() => TaskAddScreen(),
                          arguments: {"index": index, "type": TaskType.done});
                    });
              });
            }),
          ],
        ),
      );
    });
  }

  Widget taskWidget(
      {required String title, required String dateTime, required Task task}) {
    return InkWell(
      onTap: () {
        Get.to(() => TaskDetailsScreen(),
            arguments: {"task": task, "index": index});
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6.w),
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(6)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              text: title,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
            6.h.verticalSpace,
            CommonText(
              text: "Created At",
              color: Colors.grey,
              fontSize: 14.sp,
            ),
            CommonText(
              text: dateTime,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }

  Widget taskViewCard(
      {required String title,
      required List<Task> taskList,
        required TaskType taskType,
      required Function(Task) onDragStarted,
      required VoidCallback onDragCompleted,
      required void Function()? onPressedNew}) {
    return Container(
      width: 0.65.sw,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.deepPurple.shade50),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r)),
                  color: Colors.deepPurple.shade200.withOpacity(0.80),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 12.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        color: Colors.white,
                      ),
                      child: CommonText(text: title, fontSize: 14),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: CommonText(
                          text: taskList.length.toString(), fontSize: 12),
                    ),
                  ],
                ),
              ),
              10.h.verticalSpace,
              Expanded(
                child: SizedBox(
                  width: 0.65.sw,
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: taskList.length,
                    itemBuilder: (context, index) {
                      return Draggable<Task>(
                          data: taskList[index],
                          feedback: Material(
                            child: taskWidget(
                                task: taskList[index],
                                title: taskList[index].name,
                                dateTime: projectListController
                                    .formatDateTime(taskList[index].createdAt)),
                          ),
                          childWhenDragging: Container(),
                          onDragStarted: () {
                            onDragStarted(taskList[index]);
                          },
                          onDragCompleted: onDragCompleted,
                          child: taskWidget(
                            title: taskList[index].name,
                            task: taskList[index],
                            dateTime: projectListController
                                .formatDateTime(taskList[index].createdAt),
                          ));
                    },
                    separatorBuilder: (context, index) => 12.h.verticalSpace,
                  ),
                ),
              ),
            ],
          ),
          if(taskType == TaskType.todo)
          ElevatedButton(
            onPressed: onPressedNew,
            child: CommonText(text: "new"),
          ).paddingOnly(bottom: 10.h, left: 10.w),
        ],
      ),
    );
  }
}
