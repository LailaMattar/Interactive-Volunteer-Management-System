import 'package:flutter/material.dart';
import 'package:takatof/core/ui/app_ui.dart';
import 'package:takatof/management/presentation/component/my_app_bar.dart';
import 'package:takatof/management/presentation/component/volunteer_item.dart';

class VolunteersListScreen extends StatelessWidget {
  const VolunteersListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppUi.drawer(),
      appBar: MyAppBar.mine(),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context , int index){
            return VolunteerItem();
          }),
    );
  }
}
