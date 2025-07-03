import 'package:get/get.dart';
import 'package:login_ui_flutter/controllers/horse_controller.dart';
import 'package:login_ui_flutter/controllers/post_controller.dart';
import '../controllers/submit.dart';

class MyBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SubmitController());
    Get.put(HorseController());
    Get.lazyPut(() => PostController());
  }
}
