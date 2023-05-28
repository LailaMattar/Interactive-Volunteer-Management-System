import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/images/app_images.dart';
import 'package:takatof/management/domain/entities/Initiative.dart';
import 'package:takatof/management/domain/entities/event.dart';
import 'package:takatof/management/presentation/component/event_status.dart';
import 'package:takatof/management/presentation/screens/details/event_details_screen.dart';

class EventItem extends StatelessWidget {
  EventItem({
    Key? key,
    required this.index,
    required this.event,
    this.initiative
  }) : super(key: key);
  final int index;
  final Event event;
  Initiative? initiative;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 10),
      child: InkWell(
        onTap: (){
          Get.to(()=>EventDetailsScreen(index: index,event: event,initiative: initiative,));
        },
        child: Container(
          height: 270,
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
          child: Column(
            children: [
              Expanded(
                flex:3,
                child: Hero(
                  tag: 'eventImage$index',
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:const BorderRadiusDirectional.only(
                        topStart: Radius.circular(20),
                        topEnd: Radius.circular(20),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          initiative == null ?event.image:initiative!.image,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex:2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              initiative == null ? event.name : initiative!.name,
                              style:const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            '${event.numberVolunteer}',
                            style:const TextStyle(
                                fontSize: 14
                            ),
                          ),
                          const SizedBox(width: 5,),
                          SvgPicture.asset(
                            AppImages.users,
                            height: 17,
                            width: 17,
                          ),
                        ],
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            initiative == null ?event.description: initiative!.description,
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            style:const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      EventStatus(status: int.parse(event.state), size: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
