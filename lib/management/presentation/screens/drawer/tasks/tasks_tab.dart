import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takatof/management/domain/entities/task.dart';
import 'package:takatof/management/presentation/component/task_item.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({Key? key,required this.tasks}) : super(key: key);

  final List<MyTask> tasks;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context , int index){
          MyTask task = tasks[index];
          return TaskItem(task: task);
          },
      ),
    );
  }
}
