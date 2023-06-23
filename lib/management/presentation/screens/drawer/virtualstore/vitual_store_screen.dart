import 'package:flutter/material.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/images/app_images.dart';
import 'package:takatof/core/ui/app_ui.dart';
import 'package:takatof/management/presentation/component/my_app_bar.dart';

class VirtualStoreScreen extends StatelessWidget {
  const VirtualStoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.titledAppBar(title: 'المتجر الافتراضي'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(6, (index) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: AppUi.containerBoxDecoration(),
                child: Padding(
                  padding: const EdgeInsets.all(00.0),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorResources.white,
                              image: DecorationImage(
                                image: AssetImage(AppImages.frameTest),
                              )
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration:const BoxDecoration(
                            color: ColorResources.grey3,
                            borderRadius: BorderRadiusDirectional.only(
                              bottomEnd: Radius.circular(20),
                              bottomStart: Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '1000 نقطة',
                                ),
                                SizedBox(
                                  height: 25,
                                  child: ElevatedButton(onPressed: (){
                                  },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:ColorResources.greenPrimary,
                                        shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                    ), child: Text('شراء'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),

    );
  }
}
