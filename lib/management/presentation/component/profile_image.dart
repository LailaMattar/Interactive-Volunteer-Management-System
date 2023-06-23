import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/images/app_images.dart';

class ProfileImage extends StatelessWidget {
  ProfileImage({
    Key? key,
    required this.height,
    required this.width,
    required this.image,
    required this.hasFrame,
    required this.diff,
    this.frame,
    required this.file,
  }) : super(key: key);
  final double width;
  final double height;
  final String image;
  final bool hasFrame;
  final double diff;
  String? frame;
  Rx<File> file;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Visibility(
            visible: hasFrame,
            child: Container(
              // height: height,
              // width: width,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(
                          frame!
                      )
                  )
              ),
            ),
          ),
          file.value.path == ''?
          image == '' || image == null
              ?Center(
            child: Container(
              height: height,
              width: width-diff,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorResources.grey),
                  image:const DecorationImage(
                      image: AssetImage(
                        AppImages.userTest,
                      ),
                    fit: BoxFit.contain
                  )
              ),
            ),
          )
              :Center(
            child: Container(
              height: height,
              width: width-diff,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorResources.grey),
                  image: DecorationImage(
                      image: NetworkImage(
                        image,
                      ),
                      fit: BoxFit.contain
                  )
              ),
            ),
          ):Obx(
            ()=> Center(
              child: Container(
                height: height,
                width: width-diff,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: ColorResources.grey),
                    image: DecorationImage(
                        image: FileImage(
                          file!.value,
                        ),
                        fit: BoxFit.contain
                    )
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
