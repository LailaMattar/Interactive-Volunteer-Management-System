import 'package:flutter/material.dart';
import 'package:takatof/core/images/app_images.dart';
import 'package:takatof/management/domain/entities/event.dart';
import 'package:takatof/management/presentation/component/event_item.dart';

class MyEventsTab extends StatelessWidget {
  const MyEventsTab({
    Key? key,
    required this.events,
    required this.isMyState,
    required this.isAdminState
  }) : super(key: key);
  final List<Event> events;
  final bool isMyState;
  final bool isAdminState;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (BuildContext context, int index) {
          Event event = events[index];
          return EventItem(index: index, event: event,isMyState: isMyState,isAdminState:isAdminState,isAdmin: false,);
        },
      ),
    );
  }
}
