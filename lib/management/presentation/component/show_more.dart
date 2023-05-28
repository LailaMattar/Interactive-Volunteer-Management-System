import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/images/app_images.dart';
import 'package:takatof/core/strings/app_strings.dart';

class ShowMore extends StatelessWidget {
  const ShowMore({Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);
  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          child: Text(
            title,
            textAlign: TextAlign.start,
            style:const TextStyle(
                color: ColorResources.black,
                fontSize: 17
            ),
          ),
        ),
        const Expanded(child: SizedBox()),
        InkWell(
          onTap: onTap,
          child: const Text(
            AppStrings.showMore,
            style: TextStyle(
                color: ColorResources.redPrimary
            ),
          ),
        ),
        RotationTransition(
          turns:const AlwaysStoppedAnimation(180 / 360),
          child: SvgPicture.asset(AppImages.viewAllArrow, color: ColorResources.redPrimary),
        ),
      ],
    );
  }
}
