import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/images/app_images.dart';
import 'package:takatof/management/domain/entities/Initiative.dart';
import 'package:takatof/management/presentation/screens/details/initiative_details_screen.dart';

class InitiativeItem extends StatelessWidget {
  const InitiativeItem({
    Key? key,
    required this.index,
    required this.initiative,
  }) : super(key: key);
  final int index;
  final Initiative initiative;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          Get.to(InitiativeDetailsScreen(index: index,initiative: initiative,isMyState:false));
        },
        child: Container(
          height: 110,
          decoration: BoxDecoration(
            color: ColorResources.white,
            // border: Border.all(color: ColorResources.grey),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                  flex:2,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 12.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width:double.infinity,
                          child: Text(
                            initiative.name,
                            textAlign: TextAlign.start,
                            style:const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        SizedBox(
                          width:double.infinity,
                          child: Text(
                            initiative.description,
                            maxLines: 3,
                            textAlign: TextAlign.start,
                            style:const TextStyle(
                              fontSize: 12,
                              // fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              Hero(
                tag: 'initiative$index',
                child: Container(
                  height: double.infinity,
                  width: 125,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: NetworkImage(
                              initiative.image
                          ),
                          fit: BoxFit.fill
                      )
                  ),
                  // child: Image.asset(p.image,fit: BoxFit.fill,)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
