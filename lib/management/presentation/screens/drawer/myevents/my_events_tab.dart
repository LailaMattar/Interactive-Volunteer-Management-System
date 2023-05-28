import 'package:flutter/material.dart';
import 'package:takatof/core/images/app_images.dart';
import 'package:takatof/management/domain/entities/event.dart';
import 'package:takatof/management/presentation/component/event_item.dart';

class MyEventsTab extends StatelessWidget {
  const MyEventsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context , int index){
          Event event = Event(description: '',id: index, image: AppImages.test3, date: '', time: '', place: '', startRegisterDate: '', finishRegisterDate: '', numberVolunteer: 1, state: '2', noteAdmin: '', name: '', isRegistered: 1);
          return EventItem(index: index, event: event);
        },
      ),
    );
  }
}
