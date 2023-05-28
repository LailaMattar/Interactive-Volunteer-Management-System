import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';

class EvaluateBool extends StatelessWidget {
  EvaluateBool({Key? key}) : super(key: key);
  RxBool trueValue = false.obs;
  RxBool falseValue = false.obs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: Text(
                'الحضور باكراً',
                style: TextStyle(
                  color: ColorResources.grey2
                ),
              ),
            ),
            Text(
              'نعم'
            ),
            Obx(
              ()=> Checkbox(
                value: trueValue.value,
                activeColor: ColorResources.greenPrimary,
                onChanged: (bool? value) {
                  if(falseValue.isTrue) falseValue.value = false;
                  trueValue.value = value!;
                },
              ),
            ),
            const SizedBox(width: 10,),
            Text(
                'لا',
            ),
            Obx(
                  ()=> Checkbox(
                value: falseValue.value,
                    activeColor: ColorResources.greenPrimary,
                onChanged: (bool? value) {
                  if(trueValue.isTrue) trueValue.value = false;
                  falseValue.value = value!;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
