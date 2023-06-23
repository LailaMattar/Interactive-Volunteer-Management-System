import 'package:flutter/material.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/images/app_images.dart';
import 'package:takatof/core/ui/app_ui.dart';

class PostItem extends StatelessWidget {
  const PostItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: AppUi.containerBoxDecoration(),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              'إدارة تكاتف',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: ColorResources.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              'كتبت هذا المنشور من اجل تجريب اعلانات المدير يابيبي .'*3,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: ColorResources.black,
                  fontSize: 14
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AppImages.test6,
                  ),
                  // fit: BoxFit.fill
                )
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(AppImages.heartFill),
              SizedBox(width: 5,),
              Text(
                '20',
                style: TextStyle(
                    color: ColorResources.grey
                ),
              ),
              SizedBox(width: 20,),
              Icon(
                Icons.comment_outlined,
                color: ColorResources.grey,
              ),
              Text(
                '11',
                style: TextStyle(
                    color: ColorResources.grey
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
