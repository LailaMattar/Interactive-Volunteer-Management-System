import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/management/domain/entities/project.dart';
import 'package:takatof/management/presentation/screens/details/project_details_screen.dart';

class ProjectItem extends StatelessWidget {
  const ProjectItem({
    Key? key,
    required this.project,
    required this.index
  }) : super(key: key);
  final Project project;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          print('taped :${project.initiatives.length}');
          Get.to(()=> ProjectDetailsScreen(index: index,project: project,));
        },
        child: Container(
          height: double.infinity,
          width: Get.width - 100,
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
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 12.0),
                      child: Column(
                        children: [
                          SizedBox(
                            width:double.infinity,
                            child: Text(
                              project.name,
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
                              project.description,
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
                    ),
                  )
              ),
              Hero(
                tag: 'image$index',
                child: Container(
                  height: double.infinity,
                  width: 125,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: NetworkImage(
                              project.image
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
