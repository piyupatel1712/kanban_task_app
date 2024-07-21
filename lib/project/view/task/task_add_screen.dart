import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kanban_task/project/controller/project_list_controller.dart';
import 'package:kanban_task/project/model/project_model.dart';
import 'package:kanban_task/utils/app_colors.dart';
import 'package:kanban_task/widget/app_snackbar.dart';
import 'package:kanban_task/widget/common_text.dart';
import 'package:kanban_task/widget/common_textfield.dart';

class TaskAddScreen extends StatelessWidget {
  TaskAddScreen({Key? key}) : super(key: key);

  final ProjectListController _projectListController = Get.find();
  int index = 0;
  TaskType type = TaskType.todo;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectListController>(initState: (state) {
      if (Get.arguments != null) {
        index = Get.arguments["index"];
        type = Get.arguments["type"];
      }
    }, builder: (context) {
      return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: AppColors.primaryColor,
            onPressed: () {
              _projectListController.addTask(index, type);
            },
            label: Row(
              children: [
                Icon(Icons.add, color: Colors.white, size: 26.sp),
                5.w.horizontalSpace,
                CommonText(
                  text: "Add",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ],
            )),
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
                text: "Add Task",
                fontSize: 20.sp,
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CommonTextfield(
                controller: _projectListController.taskNameController,
                labelText: "Enter Task",
                limitOfText: 20),
            15.h.verticalSpace,
            CommonTextfield(
                controller: _projectListController.taskDescriptionController,
                labelText: "Enter Task Description",
                limitOfText: 450),
          ],
        ).paddingAll(16.r),
      );
    });
  }
}
