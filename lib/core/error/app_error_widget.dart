import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/strings/app_strings.dart';

class AppErrorWidget{
  static Widget error({
    required String message,
    VoidCallback? onTap,
    double? width,
    double? height,
  }){
    return SizedBox(
      height: height ,
      width: width ?? double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            message,
            // maxLines: 2,
            style:const TextStyle(
              color: ColorResources.redPrimary,
            ),
          ),
          Visibility(
            visible: onTap != null,
            child: InkWell(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorResources.redPrimary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child:const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    AppStrings.retry,
                    style: TextStyle(
                      color: ColorResources.white,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}