import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/ui/app_ui.dart';
import 'package:takatof/management/domain/entities/measurement.dart';

class EvaluateInt extends StatelessWidget {
  EvaluateInt({Key? key, required this.measurement}) : super(key: key);
  TextEditingController valueController = TextEditingController();
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
                onTap: () {
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
                child: const Icon(
                  Icons.info_outline,
                  color: ColorResources.grey,
                )),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                measurement.name,
                style: const TextStyle(color: ColorResources.grey2),
              ),
            ),
            SizedBox(
              width: 60,
              child: TextFormField(
                controller: valueController,
                cursorColor: ColorResources.greenPrimary,
                maxLines: 1,
                maxLength: 3,
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  measurement.value = int.parse(value);
                },
                decoration: const InputDecoration(
                  counterText: "",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: ColorResources.greenPrimary),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: ColorResources.grey2),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter value';
                  }
                  return '';
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
