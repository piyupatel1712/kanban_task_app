import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kanban_task/project/controller/project_list_controller.dart';
import 'package:kanban_task/project/model/project_model.dart';
import 'package:kanban_task/utils/app_colors.dart';
import 'package:kanban_task/widget/app_snackbar.dart';
import 'package:kanban_task/widget/common_text.dart';
import 'package:kanban_task/widget/common_textfield.dart';

class ProjectAddScreen extends StatelessWidget {
  ProjectAddScreen({Key? key}) : super(key: key);

  final ProjectListController _projectListController = Get.find();
  int? index;
  ProjectModel? projectModel;
  bool? isEdit;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectListController>(initState: (state) {
      final arg = Get.arguments ?? {};
      print("ardd--${arg["name"]}");

      if (arg["project"] != null) {
        projectModel = arg["project"] ?? "";
      }
      isEdit = arg["isEdit"] ?? false;

      if (isEdit ?? false) {
        _projectListController.projectNameController.text =
            projectModel?.name ?? "";
        _projectListController.projectDesController.text =
            projectModel?.description ?? "";
        index = arg["index"];
      }
    }, builder: (context) {
      return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: AppColors.primaryColor,
            onPressed: () {
              if (isEdit ?? false) {
                _projectListController.projectDataList[index ?? 0].name =
                    _projectListController.projectNameController.text;
                _projectListController.projectDataList[index ?? 0].description =
                    _projectListController.projectDesController.text;
                _projectListController.projectDataList.refresh();
                Get.back();
                _projectListController.projectNameController.clear();
                _projectListController.projectDesController.clear();

                AppSnackBar.showSnackBarAtTop(
                    message: "Project name update successfully!!",
                    color: Colors.green.shade400,
                    title: "Success");
              } else {
                if (_projectListController
                        .projectNameController.text.isNotEmpty &&
                    _projectListController
                        .projectDesController.text.isNotEmpty) {
                  _projectListController.projectDataList.add(
                    ProjectModel(
                      name: _projectListController.projectNameController.text,
                      createdAt: DateTime.now(),
                      description:
                          _projectListController.projectDesController.text,
                    ),
                  );
                  Get.back();
                  _projectListController.projectNameController.clear();
                  _projectListController.projectDesController.clear();
                  AppSnackBar.showSnackBarAtTop(
                      message: "Project added successfully!!",
                      color: Colors.green.shade400,
                      title: "Success");
                } else {
                  if (_projectListController
                          .projectNameController.text.isEmpty &&
                      _projectListController
                          .projectDesController.text.isEmpty) {
                    AppSnackBar.showSnackBarAtTop(
                        message: "Please add project details",
                        color: Colors.red.shade400,
                        title: "Error");
                  } else if (_projectListController
                      .projectNameController.text.isEmpty) {
                    AppSnackBar.showSnackBarAtTop(
                        message: "Please add project name",
                        color: Colors.red.shade400,
                        title: "Error");
                  } else if (_projectListController
                      .projectDesController.text.isEmpty) {
                    AppSnackBar.showSnackBarAtTop(
                        message: "Please add project description",
                        color: Colors.red.shade400,
                        title: "Error");
                  } else {
                    debugPrint("something went wrong");
                  }
                }
              }
            },
            label: Row(
              children: [
                Icon(Icons.add, color: Colors.white, size: 26.sp),
                5.w.horizontalSpace,
                CommonText(
                  text: (isEdit ?? false) ? "Update" : "Add",
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
                text: (isEdit ?? false)
                    ? "Edit Project Name"
                    : "Add Project Here",
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
                controller: _projectListController.projectNameController,
                labelText: "Enter Project Name",
                limitOfText: 20),
            15.h.verticalSpace,
            CommonTextfield(
                controller: _projectListController.projectDesController,
                labelText: "Enter Project Description",
                limitOfText: 25),
          ],
        ).paddingAll(16.r),
      );
    });
  }
}
