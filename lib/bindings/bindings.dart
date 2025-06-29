import 'package:get/get.dart';
import 'package:login_ui_flutter/controllers/post_controller.dart';
//
import '../controllers/submit.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SubmitController());
     Get.lazyPut(() => PostController());
  }
}
