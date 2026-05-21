import 'package:get/get.dart';
import 'package:solu_lab_asignment/app/module/cardScanner/card_scaner_controller.dart';

class CardScannerBinding extends Bindings {

  @override
  void dependencies() {

    Get.lazyPut<CardScannerController>(
      () => CardScannerController(),
    );
  }
}