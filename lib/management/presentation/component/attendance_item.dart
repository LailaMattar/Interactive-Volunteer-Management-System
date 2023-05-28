import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/images/app_images.dart';
import 'package:takatof/management/presentation/component/profile_image.dart';

class AttendanceItem extends StatelessWidget {
  AttendanceItem({Key? key}) : super(key: key);
  RxBool value = false.obs;

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
              hasFrame: true,
              image: AppImages.userTest,
              frame: AppImages.frameTest,
              diff: 30,
            ),
            const SizedBox(width: 10,),
            Text(
              'اسم المتطوع',
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
            Obx(
              ()=> Checkbox(
                  activeColor: ColorResources.greenPrimary,
                  value: value.value,
                  onChanged: (bool? value){
                    this.value.value = value!;
                  }),
            ),
            const SizedBox(width: 20,),
          ],
        ),
      ),
    );
  }
}
