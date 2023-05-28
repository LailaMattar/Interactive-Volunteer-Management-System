import 'package:flutter/material.dart';
import 'package:takatof/core/images/app_images.dart';

class ProfileImage extends StatelessWidget {
  ProfileImage({
    Key? key,
    required this.height,
    required this.width,
    required this.image,
    required this.hasFrame,
    required this.diff,
    this.frame
  }) : super(key: key);
  final double width;
  final double height;
  final String image;
  final bool hasFrame;
  final double diff;
  String? frame;

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
              height: height,
              width: width,
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
          Center(
            child: Container(
              height: height,
              width: width-diff,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(
                          image,
                      ),
                    fit: BoxFit.contain
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
