import 'package:get/get.dart';
import 'package:solu_lab_asignment/app/module/cardScanner/card_scaner_binding.dart';
import 'package:solu_lab_asignment/app/module/cardScanner/card_scaner_view.dart';
import 'package:solu_lab_asignment/app/module/home/home_view.dart';
import 'package:solu_lab_asignment/app/module/passbookScanner/passbook_binding.dart';
import 'package:solu_lab_asignment/app/module/passbookScanner/passbook_view.dart';

class AppPages {
  static final routes = [

    GetPage(
      name: '/',
      page: () => const HomeView(),
    ),
    
    GetPage(
      name: '/card',
      page: () => const CardScannerView(),
      binding: CardScannerBinding(),
    ),

    GetPage(
      name: '/passbook',
      page: () =>  PassbookScannerView(),
      binding: PassbookScannerBinding(),
    ),
  ];
}
