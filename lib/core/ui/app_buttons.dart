import 'package:flutter/material.dart';
import 'package:takatof/core/colors/colors.dart';

class AppButtons{
  static Widget mainButton({
    required String title,
    required VoidCallback onTap,
    required Color color,
  }){
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 7,
              offset:const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style:const TextStyle(
                  color: ColorResources.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 16
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget buttonWithSpace({
    required double width,
    required double height,
    required String title,
    required VoidCallback onTap,
    required Color color,
  }){
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 7,
              offset:const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style:const TextStyle(
                  color: ColorResources.white,
                  // fontWeight: FontWeight.w900,
                  fontSize: 14
              ),
            ),
          ),
        ),
      ),
    );
  }
}