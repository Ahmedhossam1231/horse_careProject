
import 'package:get/get.dart';

class HorseController extends GetxController {
  RxList<Map<String, dynamic>> horseList = <Map<String, dynamic>>[].obs;
  RxString selectedHorse = ''.obs;

  void setHorse(String horseName) {
    selectedHorse.value = horseName;
  }

  void addHorse(Map<String, dynamic> horse) {
    horseList.add(horse);
  }
}

