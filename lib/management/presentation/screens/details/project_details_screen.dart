import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/images/app_images.dart';
import 'package:takatof/core/strings/app_strings.dart';
import 'package:takatof/core/ui/app_ui.dart';
import 'package:takatof/management/domain/entities/Initiative.dart';
import 'package:takatof/management/domain/entities/project.dart';
import 'package:takatof/management/presentation/component/initiative_item.dart';
import 'package:takatof/management/presentation/component/my_app_bar.dart';

class ProjectDetailsScreen extends StatelessWidget {
  const ProjectDetailsScreen({Key? key,required this.index,required this.project}) : super(key: key);

  final int index;
  final Project project;

  @override
  Widget build(BuildContext context) {
    print('iiii :${project.initiatives.length}');
    return Scaffold(
      backgroundColor: ColorResources.white,
      drawer: AppUi.drawer(),
      appBar: MyAppBar.titledAppBar(title: 'تفاصيل المشروع'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorResources.white,
                borderRadius:const BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(30),
                  bottomEnd: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset:const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Hero(
                    tag: 'image$index',
                    child: Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorResources.white,
                        borderRadius:const BorderRadiusDirectional.only(
                          bottomStart: Radius.circular(30),
                          bottomEnd: Radius.circular(30),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                              project.image,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 15),
                    decoration:const BoxDecoration(
                      color: ColorResources.white,
                      borderRadius: BorderRadiusDirectional.only(
                        bottomStart: Radius.circular(30),
                        bottomEnd: Radius.circular(30),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            project.name,
                            style:const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          '${project.numberVolunteer}',
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
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'اسم المشرف : ليلى مطر',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: ColorResources.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      AppStrings.projectDescription,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: ColorResources.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      project.description,
                      textAlign: TextAlign.start,
                      style:const TextStyle(
                        color: ColorResources.grey2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      AppStrings.projectInitiative,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: ColorResources.black,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  ListView.builder(
                    itemCount: project.initiatives.length,
                      shrinkWrap: true,
                      physics:const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index){
                      Initiative initiative = project.initiatives[index];
                        return InitiativeItem(index:index,initiative: initiative,);
                      },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
