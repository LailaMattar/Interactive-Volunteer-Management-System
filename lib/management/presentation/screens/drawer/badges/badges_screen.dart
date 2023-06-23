import 'package:flutter/material.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/images/app_images.dart';
import 'package:takatof/core/ui/app_ui.dart';
import 'package:takatof/management/presentation/component/my_app_bar.dart';

class BadgesScreen extends StatefulWidget {
  const BadgesScreen({Key? key}) : super(key: key);

  @override
  State<BadgesScreen> createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> with TickerProviderStateMixin{
  late AnimationController _favoriteController;

  @override
  void initState() {
    super.initState();
    _favoriteController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _favoriteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.titledAppBar(title: 'الشارات'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(6, (index) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                children: [
                  Container(
                    decoration: AppUi.containerBoxDecoration(),
                    child: Padding(
                      padding: const EdgeInsets.all(00.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                            child: Text(
                              'شارة الالتزام',
                              style: TextStyle(
                                color: ColorResources.black,
                                fontSize: 17
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration:const BoxDecoration(
                                    color: ColorResources.white,
                                    image: DecorationImage(
                                      image: AssetImage(AppImages.badgeTest),
                                      fit: BoxFit.contain,
                                    )
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorResources.greyWithOpacity,
                    ),
                  ),
                  InkWell(
                    onTap: (){

                    },
                    child: Center(
                      child: Image.asset(
                        AppImages.lock,
                        height: 85,
                        width: 85,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),

    );
  }
}
