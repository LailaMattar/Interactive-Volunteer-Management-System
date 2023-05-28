import 'package:flutter/material.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/strings/app_strings.dart';

class EventStatus extends StatelessWidget {
  EventStatus({
    Key? key,
    required this.status,
    required this.size,
  }) : super(key: key);
  final int status;
  final double size;
  late IconData icon;
  late String title;

  @override
  Widget build(BuildContext context) {
    if(status == 1){
      icon = Icons.access_time_sharp;
      title= AppStrings.openToRegister;
    }else if(status == 2){
      icon = Icons.more_horiz;
      title= AppStrings.inProgress;
    }else if(status == 3){
      icon = Icons.check;
      title= AppStrings.finished;
    }
    return Row(
      children: [
        Icon(
          icon,
          color: ColorResources.greenPrimary,
          size: 15,
        ),
        const SizedBox(width: 5,),
        Text(
          title,
          style: TextStyle(
              fontSize: size,
              color: ColorResources.greenPrimary
          ),
        ),
      ],
    );
  }
}
