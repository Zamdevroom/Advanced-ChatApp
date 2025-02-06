import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wa_business/Islam/screens/Settings/settingController.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final settingCont getxSetting = Get.put(settingCont());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      body: Column(
        children: [
          Obx(()=>
              Slider(
                  value: getxSetting.sliderValue.value,
                  min: 0.5,
                  max: 1.5,
                  onChanged: (value){
                    getxSetting.updateValue(value);
                    print(getxSetting.sliderValue.value);
                  }),
          ),
        ],
      ),
      );
  }
}

