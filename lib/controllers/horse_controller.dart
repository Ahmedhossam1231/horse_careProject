import 'package:get/get.dart';

class HorseController extends GetxController {
  RxList<Map<String, dynamic>> horseList = <Map<String, dynamic>>[].obs;

  // ✅ selectedHorse = حصان كامل (Map)
  RxMap<String, dynamic> selectedHorse = <String, dynamic>{}.obs;

  // بيانات يومية لكل حصان
  RxMap<String, Map<String, dynamic>> horseDailyData =
      <String, Map<String, dynamic>>{}.obs;

  void setHorse(Map<String, dynamic> horse) {
    selectedHorse.value = horse;
  }

  void addHorse(Map<String, dynamic> horse) {
    horseList.add(horse);
    horseDailyData.putIfAbsent(horse['name'], () => {});
  }

  void saveDailyDataForSelectedHorse(Map<String, dynamic> data) {
    final name = selectedHorse['name'];
    if (name != null && name.isNotEmpty) {
      horseDailyData[name] = data;
    }
  }

  Map<String, dynamic> getDailyDataForSelectedHorse() {
    final name = selectedHorse['name'];
    return horseDailyData[name] ?? {};
  }
}
