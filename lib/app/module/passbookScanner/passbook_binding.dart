import 'package:get/get.dart';

import 'passbook_controller.dart';

class PassbookScannerBinding extends Bindings {

  @override
  void dependencies() {

    Get.lazyPut<PassbookScannerController>(
      () => PassbookScannerController(),
    );
  }
}