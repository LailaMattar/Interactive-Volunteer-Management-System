import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:image_picker/image_picker.dart';

class AppConstance {
  static final zoomDrawerController = ZoomDrawerController();
  static late String role;
  static late int id;
  static bool eventCondition(
      {required bool isAdmin, required String eventState}) {
    return  isAdmin == true && eventState == '2';
  }

  static Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      debugPrint('image picked successfully');
      return imageTemp;
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }
}
