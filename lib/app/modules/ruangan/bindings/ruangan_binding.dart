import 'package:get/get.dart';
import '../controllers/ruangan_controller.dart';

class RuanganBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RuanganController>(() => RuanganController());
  }
}
