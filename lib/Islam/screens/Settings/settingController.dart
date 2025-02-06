import 'package:get/get.dart';

class settingCont extends GetxController{
  var sliderValue = 1.0.obs;

  void updateValue(double val){
    sliderValue.value = val;
  }
}