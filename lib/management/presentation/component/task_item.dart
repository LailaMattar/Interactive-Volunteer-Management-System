import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/strings/app_strings.dart';
import 'package:takatof/core/ui/app_ui.dart';
import 'package:takatof/management/domain/entities/task.dart';
import 'package:takatof/management/presentation/screens/drawer/tasks/task_details_screen.dart';

class TaskItem extends StatelessWidget {
  TaskItem({Key? key,required this.task}) : super(key: key);
  final MyTask task;
  late String state;

  @override
  Widget build(BuildContext context) {
    if(task.state == '1'){
      state = 'معلقة';
    }else if(task.state == '2'){
      state = 'قيد التنفيذ';
    }else{
      state = 'منتهية';
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: 100,
        padding: const EdgeInsets.all(8),
        decoration: AppUi.containerBoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    task.name,
                    style:const TextStyle(
                      color: ColorResources.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '${task.numberHour} ساعات',
                    style:const TextStyle(
                        color: ColorResources.black,
                        fontSize: 15
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'موعد التسليم: ${task.dateDelivery}',
                    style:const TextStyle(
                      color: ColorResources.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '50 نقطة',
                    style: TextStyle(
                        color: ColorResources.black,
                        fontSize: 15
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    state,
                    style:const TextStyle(
                        color: ColorResources.greenPrimary,
                        fontSize: 15
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){
                      Get.to(()=> TaskDetailsScreen(task: task,state: state,));
                    },
                    child:const Text(
                      AppStrings.showMore,
                      style: TextStyle(
                          color: ColorResources.redPrimary,
                          fontSize: 15
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
