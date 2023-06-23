import 'package:flutter/material.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/images/app_images.dart';
import 'package:takatof/core/ui/app_ui.dart';
import 'package:takatof/management/domain/entities/point.dart';
import 'package:takatof/management/presentation/component/my_app_bar.dart';

class PointsDetailsScreen extends StatelessWidget {
  const PointsDetailsScreen({Key? key,required this.points}) : super(key: key);
  final List<AppPoint> points;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.titledAppBar(title: 'تفاصيل النقاط'),
      body: ListView.builder(
        itemCount: points.length,
          itemBuilder: (BuildContext context , int index){
          AppPoint point = points[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
              child: Container(
                // height: 100,
                decoration: AppUi.containerBoxDecoration(),
                padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            point.evaluationName,
                            style:const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: ColorResources.greenPrimary,
                            ),
                          ),
                        ),
                        const Image(image: AssetImage(AppImages.diamond)),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        point.evaluationName,
                        style:const TextStyle(
                          fontSize: 15,
                          color: ColorResources.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'النقاط المكتسبة: ${point.amount}',
                          textAlign: TextAlign.start,
                          style:const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          'تاريخ المنح: ${point.eventDate}',
                          textAlign: TextAlign.start,
                          style:const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
