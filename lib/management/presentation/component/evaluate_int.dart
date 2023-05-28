import 'package:flutter/material.dart';
import 'package:takatof/core/colors/colors.dart';
import 'package:takatof/core/ui/app_ui.dart';

class EvaluateInt extends StatelessWidget {
  EvaluateInt({Key? key}) : super(key: key);
  TextEditingController valueController = TextEditingController();

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
                'عدد الأشجار التي زرعها',
                style: TextStyle(
                  color: ColorResources.grey2
                ),
              ),
            ),
            Container(
              width: 60,
              child: TextFormField(
                controller: valueController,
                cursorColor: ColorResources.greenPrimary,
                maxLines: 1,
                maxLength: 3,
                keyboardType: TextInputType.number,
                decoration:const InputDecoration(
                  counterText: "",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: ColorResources.greenPrimary),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: ColorResources.grey2),
                  ),
                ),
                validator: (value){
                  if(value!.isEmpty){
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
