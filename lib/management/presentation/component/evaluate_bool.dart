import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/management/domain/entities/measurement.dart';

class EvaluateBool extends StatelessWidget {
  EvaluateBool({Key? key,required this.measurement}) : super(key: key);
  RxBool trueValue = false.obs;
  RxBool falseValue = false.obs;
  Measurement measurement;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            InkWell(
              onTap: (){
                Get.dialog(
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: AlertDialog(
                      title: const Text(
                        'التفاصيل',
                        textAlign: TextAlign.center,
                      ),
                      titleTextStyle: const TextStyle(
                        color: ColorResources.black,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                      content: Text(measurement.description),
                      contentTextStyle: const TextStyle(
                        color: ColorResources.black,
                        fontSize: 17,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          child:const Text(
                            'حسناً',
                            style:
                            TextStyle(color: ColorResources.greenPrimary),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
                child: const Icon(Icons.info_outline,color: ColorResources.grey,)
            ),
            const SizedBox(width: 5,),
            Expanded(
              child: Text(
                measurement.name,
                style:const TextStyle(
                  color: ColorResources.grey2
                ),
              ),
            ),
            const Text(
              'نعم'
            ),
            Obx(
              ()=> Checkbox(
                value: trueValue.value,
                activeColor: ColorResources.greenPrimary,
                onChanged: (bool? value) {
                  if(falseValue.isTrue) falseValue.value = false;
                  trueValue.value = value!;
                  measurement.value = 1;
                },
              ),
            ),
            const SizedBox(width: 10,),
            const Text(
                'لا',
            ),
            Obx(
                  ()=> Checkbox(
                value: falseValue.value,
                    activeColor: ColorResources.greenPrimary,
                onChanged: (bool? value) {
                  if(trueValue.isTrue) trueValue.value = false;
                  falseValue.value = value!;
                  measurement.value = 0;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
