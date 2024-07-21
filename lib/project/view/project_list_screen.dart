import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:kanban_task/project/controller/project_list_controller.dart';
import 'package:kanban_task/project/model/project_model.dart';
import 'package:kanban_task/project/view/project_add_screen.dart';
import 'package:kanban_task/project/view/task/task_view_screen.dart';
import 'package:kanban_task/utils/app_colors.dart';
import 'package:kanban_task/widget/common_text.dart';

class ProjectListScreen extends StatelessWidget {
  ProjectListScreen({Key? key}) : super(key: key);
  final ProjectListController _projectListController =
      Get.put(ProjectListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45.h,
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Project List",
          style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w600),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          Get.to(() => ProjectAddScreen(), arguments: {
            "isEdit": false,
            "name": "",
          });
        },
        child: Icon(Icons.add, color: Colors.white, size: 28.sp),
      ),
      body: Obx(
        () => MasonryGridView.count(
          shrinkWrap: true,
          itemCount: _projectListController.projectDataList.length,
          itemBuilder: (context, index) {
            ProjectModel project =
                _projectListController.projectDataList[index];
            return InkWell(
              onTap: () {
                Get.to(TaskViewScreen(),
                    arguments: {"project": project, "index": index});
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Colors.deepPurpleAccent.shade100.withOpacity(0.27)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Obx(() {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                                    text: project.name,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600)
                                .paddingAll(8),
                            Container(
                              width: 1.sw,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade200,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: CommonText(
                                      text: project.description,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400)
                                  .paddingAll(8),
                            ),
                            12.h.verticalSpace,
                            buttonCart(
                                buttonName:
                                    "To-Do  ${project.todoList.length ?? 0}"),
                            8.h.verticalSpace,
                            buttonCart(
                                buttonName:
                                    "Progress  ${project.progressList.length ?? 0}"),
                            8.h.verticalSpace,
                            buttonCart(
                                buttonName:
                                    "Done  ${project.doneList.length ?? 0}"),
                            CommonText(
                                    text: _projectListController.formatDateTime(
                                        _projectListController
                                            .projectDataList[index].createdAt),
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500)
                                .paddingAll(10),
                          ],
                        );
                      }),
                    ),
                    // InkWell(
                    //     onTap: () {
                    //       Get.to(ProjectAddScreen(),arguments: {
                    //         "isEdit":true,
                    //         "index":index,
                    //         "project":_projectListController.projectDataList[index]
                    //       });
                    //     },
                    //     child: Icon(Icons.edit,size: 20.sp,).paddingOnly(right:8.w),),
                  ],
                ),
              ),
            );
          },
          crossAxisCount: 2,
        ),
      ),
    );
  }

  Widget buttonCart({required String buttonName}) {
    return Container(
      margin: EdgeInsets.only(left: 12.w),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r), color: Colors.white),
      child: CommonText(
        text: buttonName,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Colors.deepPurple,
      ),
    );
  }
}
