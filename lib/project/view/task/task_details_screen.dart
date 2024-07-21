import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kanban_task/project/controller/project_list_controller.dart';
import 'package:kanban_task/project/model/project_model.dart';
import 'package:kanban_task/widget/app_snackbar.dart';
import 'package:kanban_task/widget/common_text.dart';
import 'package:kanban_task/widget/common_textfield.dart';

import '../../../utils/app_colors.dart';

class TaskDetailsScreen extends StatelessWidget {
  TaskDetailsScreen({super.key});

  ProjectListController projectListController = Get.find();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectListController>(initState: (state) {
      if (Get.arguments != null) {
        projectListController.selectedTask.value = Get.arguments["task"];
        index = Get.arguments["index"];
        projectListController.selectedProject.refresh();
      }
    }, builder: (context1) {
      return Scaffold(
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
                text: "Task",
                fontSize: 20.sp,
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 1.sw,
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.deepPurple.shade50,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: "Title",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                      CommonText(
                        text: projectListController.selectedTask.value.name,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      8.h.verticalSpace,
                      CommonText(
                        text: "Created At",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                      CommonText(
                        text: projectListController.formatDateTime(
                            projectListController.selectedTask.value.createdAt),
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      8.h.verticalSpace,
                      CommonText(
                        text: "Description",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                      CommonText(
                        text: projectListController
                            .selectedTask.value.description,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                20.h.verticalSpace,
                Obx(
                  () {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: projectListController
                              .selectedTask.value.commentList?.length ??
                          0,
                      itemBuilder: (context, index) {
                        return commentWidget(projectListController
                            .selectedTask.value.commentList![index]);
                      },
                      separatorBuilder: (context, index) => 6.h.verticalSpace,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          padding: EdgeInsets.all(16.r),
          width: 1.sw,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: CommonTextfield(
                  controller: projectListController.commentController,
                  labelText: "Add Comment",
                ),
              ),
              12.w.horizontalSpace,
              IconButton(
                  onPressed: () {
                    if (projectListController.commentController.text.isEmpty) {
                      AppSnackBar.showSnackBarAtTop(
                          message: "Please add comment",
                          color: Colors.red.shade400,
                          title: "Error");
                    } else {
                      projectListController.selectedTask.value.commentList?.add(
                          Comment(
                              name:
                                  projectListController.commentController.text,
                              createdAt: DateTime.now()));
                      projectListController.selectedTask.refresh();
                      projectListController.selectedTask.value.commentList
                          ?.refresh();
                      projectListController.projectDataList.refresh();
                      projectListController.commentController.clear();
                      FocusScope.of(context).unfocus();
                    }
                  },
                  icon: Icon(Icons.send)),
            ],
          ),
        ),
      );
    });
  }

  Widget commentWidget(Comment comment) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
              constraints: BoxConstraints(
                maxWidth: 0.80.sw,
              ),
              decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100.withOpacity(0.30),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14.r),
                    topRight: Radius.circular(14.r),
                    bottomLeft: Radius.circular(14.r),
                  )),
              child: CommonText(
                text: comment.name,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            2.h.verticalSpace,
            CommonText(
              text: projectListController.formatDateTime(comment.createdAt),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ],
        ),
      ],
    );
  }
}
