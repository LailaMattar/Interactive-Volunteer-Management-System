import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/images/app_images.dart';
import 'package:takatof/management/domain/entities/volunteer.dart';
import 'package:takatof/management/presentation/component/my_app_bar.dart';
import 'package:takatof/management/presentation/component/profile_image.dart';
import 'package:takatof/management/presentation/screens/details/volunteer_details_screen.dart';

class VolunteersScreen extends StatelessWidget {
  const VolunteersScreen({Key? key,required this.volunteers}) : super(key: key);
  final List<Volunteer> volunteers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.titledAppBar(title: 'المتطوعين المشاريكن'),
      body: ListView.builder(
        itemCount: volunteers.length,
          itemBuilder: (BuildContext context , int index){
          Volunteer volunteer = volunteers[index];
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
                  image: volunteer.image,
                  frame: AppImages.frameTest,
                  diff: 30,
                  file:Rx<File>(File('')),
                ),
                const SizedBox(width: 10,),
                Text(
                  volunteer.name,
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
                ElevatedButton(
                    onPressed: (){
                      Get.to(()=> VolunteerDetailsScreen(id: volunteer.id,));
                    },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:ColorResources.greenPrimary,
                  ),
                    child: Text('عرض'),
                ),
                const SizedBox(width: 20,),
              ],
            ),
          ),
        );
      },),
    );
  }
}
