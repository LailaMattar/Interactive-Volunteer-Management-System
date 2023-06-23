import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/images/app_images.dart';
import 'package:takatof/core/strings/app_strings.dart';
import 'package:takatof/core/ui/app_buttons.dart';
import 'package:takatof/management/domain/entities/event.dart';
import 'package:takatof/management/domain/entities/volunteer.dart';
import 'package:takatof/management/presentation/component/profile_image.dart';
import 'package:takatof/management/presentation/screens/evaluation/evaluation_screen.dart';

class VolunteerItem extends StatelessWidget {
  const VolunteerItem({
    Key? key,
    required this.volunteer,
    required this.event,
  }) : super(key: key);
  final Volunteer volunteer;
  final Event event;
static bool isRate = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorResources.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 8,
              offset:const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            ProfileImage(
                height: double.infinity,
                width: 75,
                hasFrame: false,
                image: AppImages.userTest,
                frame: AppImages.frameTest,
                diff: 30,
                file:Rx<File>(File('')),
              ),
            // ),
            const SizedBox(width: 10,),
            Text(
              '${volunteer.name}',
              style: TextStyle(
                color: ColorResources.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Container(
              ),
            ),
            ElevatedButton(onPressed: volunteer.isEvaluation == 1 ? null : (){
              Get.to(()=> EvaluationScreen(volunteer: volunteer,event: event,));
            },
              style: ElevatedButton.styleFrom(
                backgroundColor:ColorResources.greenPrimary,
              ), child: Text(volunteer.isEvaluation == 1?'تم التقييم':AppStrings.evaluation),
            ),
            // AppButtons.buttonWithSpace(
            //   onTap:  (){
            //     Get.to(()=> EvaluationScreen(volunteer: volunteer,event: event,));
            //   },
            //   title: AppStrings.evaluation,
            //   color: ColorResources.greenPrimary,
            //   height: 40,
            //   width: 60,
            // ),
            const SizedBox(width: 20,),
          ],
        ),
      ),
    );
  }
}
