import 'package:get/get.dart';
import 'package:story_creator_plus/src/controller/editing_controller.dart';

class EditingBinding implements Bindings {
// default dependency
  @override
  void dependencies() {
    Get.lazyPut(() => EditingController());
  }
}
