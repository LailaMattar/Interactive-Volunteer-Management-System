import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/error/app_error_widget.dart';
import 'package:takatof/core/images/app_images.dart';
import 'package:takatof/core/services/services_locator.dart';
import 'package:takatof/core/ui/app_ui.dart';
import 'package:takatof/core/utils/app_constance.dart';
import 'package:takatof/core/utils/enums.dart';
import 'package:takatof/management/domain/entities/profile.dart';
import 'package:takatof/management/domain/usecases/get_profile_usecase.dart';
import 'package:takatof/management/domain/usecases/upload_profile_image_usecase.dart';
import 'package:takatof/management/presentation/component/profile_image.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:takatof/management/presentation/controllers/profile_controller.dart';
import 'package:takatof/management/presentation/controllers/profile_save_image_state.dart';
import 'package:takatof/management/presentation/controllers/profile_state.dart';
import 'package:takatof/management/presentation/screens/details/point_details_screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState(id: this.id);
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  _ProfileScreenState({required this.id});

  late ProfileController controller;
  final int id;
  final file = Rx<File>(File(''));

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  int points = 600;
  final List<ChartData> chartData = [
    ChartData(1, 1, 50),
    ChartData(2, 20, 200),
    ChartData(3, 5, 30),
    ChartData(4, 0, 0),
    ChartData(5, 20, 250),
    ChartData(6, 25, 150),
  ];

  late AnimationController animationController;
  late Animation<int> _animation;
  late Animation<int> _hour;
  late Animation<int> _events;
  late Animation<int> _badges;
  AudioPlayer audioPlayer = AudioPlayer();

  loadAudio() async {
    audioPlayer.play(AssetSource('coin.mp3'));
  }

  @override
  void dispose() {
    animationController.dispose();
    controller.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      file.value = File(
          pickedFile.path); // update _image Rx variable after image selection
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.delete<ProfileController>();
    controller = Get.put(
      ProfileController(
        getProfileUseCase: sl<GetProfileUseCase>(),
        uploadProfileImageUseCase: sl<UploadProfileImageUseCase>(),
        state: ProfileState().obs,
        sendState: const ProfileSaveImageState(state: RequestState.wait).obs,
        context: context,
      ),
    );
    controller.getProfile(GetProfileParameters(id: id));
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          switch (controller.state.value.state) {
            case RequestState.loading:
              return AppUi.spinkitMain;
            case RequestState.error:
              return AppErrorWidget.error(
                  message: controller.state.value.message,
                  onTap: () {
                    controller.getProfile(GetProfileParameters(id: id));
                  });
            case RequestState.wait:
              return Container();
            case RequestState.loaded:
              Profile profile = controller.state.value.profile!;
              _animation = IntTween(begin: 0, end: profile.pointNumber)
                  .animate(animationController);
              _hour = IntTween(begin: 0, end: profile.hourNumber)
                  .animate(animationController);
              _events = IntTween(begin: 0, end: profile.events.length)
                  .animate(animationController);
              _badges = IntTween(begin: 0, end: profile.badges.length)
                  .animate(animationController);
              animationController.forward();
              loadAudio();
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: InkWell(
                        onTap: () async {
                          await _pickImage();
                        },
                        child: Obx(
                          () => SizedBox(
                            width: 150,
                            height: 150,
                            child: Stack(
                              children: [
                                Visibility(
                                  visible: false,
                                  child: Container(
                                    // height: height,
                                    // width: width,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                AppImages.frameTest))),
                                  ),
                                ),
                                file.value.path == ''
                                    ? profile.image == '' ||
                                            profile.image == null
                                        ? Center(
                                            child: Container(
                                              height: 150,
                                              width: 150 - 50,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color:
                                                          ColorResources.grey),
                                                  color: ColorResources.grey3,
                                                  // image: const DecorationImage(
                                                  //     image: AssetImage(
                                                  //       AppImages.userTest,
                                                  //     ),
                                                  //     fit: BoxFit.contain
                                                  // ),
                                              ),
                                              child: SizedBox(
                                                height: 50,
                                                width: 50,
                                                child: Center(
                                                    child: Icon(Icons.person,color: ColorResources.white,size: 55,)),
                                              ),
                                            ),
                                          )
                                        : Center(
                                            child: Container(
                                              height: 150,
                                              width: 150 - 50,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color:
                                                          ColorResources.grey),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                        profile.image,
                                                      ),
                                                      fit: BoxFit.contain)),
                                            ),
                                          )
                                    : Obx(
                                        () => Center(
                                          child: Container(
                                            height: 150,
                                            width: 150 - 50,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: ColorResources.grey),
                                                image: DecorationImage(
                                                    image: FileImage(
                                                      file!.value,
                                                    ),
                                                    fit: BoxFit.contain)),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      profile.name,
                      style: const TextStyle(
                        color: ColorResources.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      profile.profession,
                      style: const TextStyle(
                        color: ColorResources.black,
                        fontSize: 16,
                      ),
                    ),
                    Visibility(
                        visible: file.value.path != '',
                        child: const SizedBox(
                          height: 10,
                        )),
                    Visibility(
                      visible: file.value.path != '',
                      child: ElevatedButton(
                        onPressed: () {
                          controller.saveProfileImage(UploadProfileImageParameters(
                              path: file.value.path,
                            imageName: file.value.path.split("/").last,
                            volunteerId: AppConstance.id.toString(),

                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorResources.greenPrimary,
                        ),
                        child: const Text('تعديل الصورة'),
                      ),
                    ),
                    Obx(
                        (){
                          switch(controller.sendState.value.state){

                            case RequestState.loading:
                              return AppUi.spinkitMain;
                            case RequestState.error:
                              return AppErrorWidget.error(message: controller.sendState.value.message,
                              );
                            case RequestState.wait:
                              return Container();
                            case RequestState.loaded:
                              WidgetsBinding.instance.addPostFrameCallback((_){
                                // AppUi.showToast(message: controller.taskProcessingState.value.taskProcessingResponse);

                              });
                              return Container();
                          }
                        }
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => PointsDetailsScreen(
                              points: profile.points,
                            ));
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: AppUi.containerBoxDecoration(),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      'رصيد النقاط',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      AnimatedBuilder(
                                        animation: _animation,
                                        builder: (BuildContext context,
                                            Widget? child) {
                                          return Text(
                                            '${_animation.value}',
                                            style: TextStyle(
                                                fontSize: 22.0,
                                                color: ColorResources
                                                    .greenPrimary),
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      const Image(
                                          image: AssetImage(AppImages.diamond)),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      'استمر للحصول على المزيد',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Image(image: AssetImage(AppImages.cart)),
                            const SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Text(
                        'المعلومات الأساسية',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: AppUi.containerBoxDecoration(),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'اجمالي ساعات التطوع: ',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                AnimatedBuilder(
                                  animation: _hour,
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return Text(
                                      '${_hour.value}',
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          color: ColorResources.greenPrimary),
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'اجمالي الفعاليات المشارك بها: ',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                AnimatedBuilder(
                                  animation: _hour,
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return Text(
                                      '${_events.value}',
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          color: ColorResources.greenPrimary),
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'اجمالي الشارات: ',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                AnimatedBuilder(
                                  animation: _badges,
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return Text(
                                      '${_badges.value}',
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          color: ColorResources.greenPrimary),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Text(
                        'شاراتي',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 130,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: profile.badges.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Get.dialog(
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Stack(
                                          children: [
                                            Center(
                                              child: SizedBox(
                                                width: Get.width / 2,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 50,
                                                      color: Colors.transparent,
                                                    ),
                                                    Container(
                                                      height: 30,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadiusDirectional.only(
                                                                topEnd: Radius
                                                                    .circular(
                                                                        30),
                                                                topStart: Radius
                                                                    .circular(
                                                                        30)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Center(
                                                child: Image.asset(
                                                    AppImages.badgeTest)),
                                          ],
                                        ),
                                        Center(
                                          child: Container(
                                            width: Get.width / 2,
                                            color: Colors.white,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    profile.badges[index].name,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: ColorResources
                                                            .black,
                                                        textBaseline:
                                                            TextBaseline
                                                                .alphabetic),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    profile.badges[index]
                                                        .description,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: ColorResources
                                                            .black),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop();
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        ColorResources
                                                            .greenPrimary,
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                  ),
                                                  child: Text('حسناً'),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Container(
                                            width: Get.width / 2,
                                            height: 10,
                                            decoration: const BoxDecoration(
                                              color: ColorResources.white,
                                              borderRadius:
                                                  BorderRadiusDirectional.only(
                                                      bottomStart:
                                                          Radius.circular(30),
                                                      bottomEnd:
                                                          Radius.circular(30)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 85,
                                decoration: AppUi.containerBoxDecoration(),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                          image: NetworkImage(
                                              profile.badges[index].image),
                                          // fit: BoxFit.cover
                                        )),
                                      ),
                                    ),
                                    Container(
                                      height: 0.5,
                                      color: ColorResources.grey,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text(
                                          profile.badges[index].name,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: ColorResources.grey,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Text(
                        'مخطط الساعات',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Center(
                        child: Container(
                            child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
                                primaryYAxis: NumericAxis(),

                                // series: <LineSeries<SalesData, String>>[
                                //   LineSeries<SalesData, String>(
                                //     // Bind data source
                                //       dataSource:  <SalesData>[
                                //         SalesData('Jan', 35),
                                //         SalesData('Feb', 28),
                                //         SalesData('Mar', 34),
                                //         SalesData('Apr', 32),
                                //         SalesData('May', 40)
                                //       ],
                                //       xValueMapper: (SalesData sales, _) => sales.year,
                                //       yValueMapper: (SalesData sales, _) => sales.sales
                                //   )
                                // ]
                                series: <ChartSeries<ChartData, int>>[
                          ColumnSeries<ChartData, int>(
                              color: ColorResources.red2,
                              dataSource: chartData,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y),
                          // ColumnSeries<ChartData, double>(
                          //     dataSource: chartData,
                          //     xValueMapper: (ChartData data, _) => data.x,
                          //     yValueMapper: (ChartData data, _) => data.y1
                          // ),
                        ]))),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              );
          }
        }),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class ChartData {
  ChartData(this.x, this.y, this.y1);
  final int x;
  final int y;
  final int y1;
}
