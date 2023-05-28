import 'package:flutter/material.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/strings/app_strings.dart';
import 'package:takatof/core/ui/app_buttons.dart';
import 'package:takatof/core/ui/app_ui.dart';
import 'package:takatof/management/presentation/component/evaluate_bool.dart';
import 'package:takatof/management/presentation/component/evaluate_int.dart';
import 'package:takatof/management/presentation/component/my_app_bar.dart';

class EvaluationScreen extends StatelessWidget {
  const EvaluationScreen({Key? key}) : super(key: key);

  Widget text({required String title, required String value}){
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Text(
            '$title: ',
            textAlign: TextAlign.start,
            style:const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorResources.greenPrimary
            ),
          ),
          Text(
            value,
            textAlign: TextAlign.start,
            style:const TextStyle(
                fontSize: 18,
                color: ColorResources.black
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppUi.drawer(),
      appBar: MyAppBar.mine(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                decoration: AppUi.containerBoxDecoration(),
                child: Column(
                  children: [
                    const SizedBox(height: 5,),
                    text(
                      title: AppStrings.volunteerName,
                      value: 'ليلى مطر',
                    ),
                    const SizedBox(height: 8,),
                    text(
                      title: AppStrings.eventName,
                      value: 'همم 1',
                    ),
                    const SizedBox(height: 8,),
                    text(
                      title: AppStrings.initiativeName,
                      value: 'همم',
                    ),
                    const SizedBox(height: 8,),
                    const SizedBox(height: 8,),
                    text(
                      title: AppStrings.eventDate,
                      value: '15-5-2023',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              const Text(
                'نعم أو لا',
                style: TextStyle(
                  color: ColorResources.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5,),
              Container(
                width: double.infinity,
                decoration: AppUi.containerBoxDecoration(),
                child: ListView.builder(
                  itemCount:3,
                  shrinkWrap: true,
                  physics:const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index){
                    return EvaluateBool();
                  },
                ),
              ),
              const SizedBox(height: 10,),
              const Text(
                'قيمة عددية',
                style: TextStyle(
                  color: ColorResources.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5,),
              Container(
                width: double.infinity,
                decoration: AppUi.containerBoxDecoration(),
                child: ListView.builder(
                  itemCount:3,
                  shrinkWrap: true,
                  physics:const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index){
                    return EvaluateInt();
                  },
                ),
              ),
              const SizedBox(height: 10,),
              const Text(
                'ملاحظات',
                style: TextStyle(
                  color: ColorResources.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5,),
              SizedBox(
                height: 150,
                child: TextFormField(
                  maxLines: 5,
                  cursorColor: ColorResources.greenPrimary,
                  decoration:const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: ColorResources.grey2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: ColorResources.greenPrimary),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 90.0),
                child: AppButtons.mainButton(
                  title: AppStrings.send,
                  color: ColorResources.greenPrimary,
                  onTap: (){

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
