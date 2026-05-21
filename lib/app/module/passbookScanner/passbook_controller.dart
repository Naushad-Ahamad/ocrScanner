import 'dart:io';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:solu_lab_asignment/app/common/common_popup.dart';
import 'package:solu_lab_asignment/app/data/models/bank_model.dart';
import 'package:solu_lab_asignment/app/data/services/ocr_service.dart';
import 'package:solu_lab_asignment/app/utils/parsers/passbook_parser.dart';

class PassbookScannerController
    extends GetxController {

  /// SELECTED IMAGE

  Rx<File?> selectedImage = Rx<File?>(null);

  /// LOADING

  RxBool isLoading = false.obs;

  /// BANK DETAILS

  Rx<BankDetailsModel?> bankDetails =
      Rx<BankDetailsModel?>(null);

  /// RAW OCR TEXT

  RxString rawText = ''.obs;

  /// CAMERA SCAN

  Future<void> scanPassbookFromCamera() async {

    try {

      final picker = ImagePicker();

      final image = await picker.pickImage(

        source: ImageSource.camera,

        imageQuality: 85,
      );

      if (image == null) return;

      await processImage(image.path);

    } catch (e) {

      CommonPopup.showErrorPopup(

        title: "Error",

        message:
            "Something went wrong while opening the camera.",
      );
    }
  }

  /// GALLERY SCAN

  Future<void> scanPassbookFromGallery() async {

    try {

      final picker = ImagePicker();

      final image = await picker.pickImage(

        source: ImageSource.gallery,

        imageQuality: 85,
      );

      if (image == null) return;

      await processImage(image.path);

    } catch (e) {

      CommonPopup.showErrorPopup(

        title: "Error",

        message:
            "Something went wrong while selecting image.",
      );
    }
  }

  /// PROCESS IMAGE

  Future<void> processImage(String path) async {

    try {

      selectedImage.value = File(path);

      isLoading.value = true;

      /// OCR TEXT EXTRACTION

      final extractedText =
          await OCRService.extractText(
        selectedImage.value!,
      );

      rawText.value = extractedText;

      /// PARSE PASSBOOK

      final parsedBank =
          PassbookParser.parsePassbook(
        extractedText,
      );

      /// ======================================
      /// STRICT PASSBOOK VALIDATION
      /// ======================================

      bool hasAccountNumber =
          parsedBank.accountNumber.isNotEmpty;

      bool hasIfsc =
          parsedBank.ifscCode.isNotEmpty;

      /// CHECK BANK KEYWORDS

      String upperText =
          extractedText.toUpperCase();

      bool hasBankKeyword =

          upperText.contains("BANK") ||
          upperText.contains("PASSBOOK") ||
          upperText.contains("ACCOUNT") ||
          upperText.contains("A/C") ||
          upperText.contains("IFSC") ||
          upperText.contains("BRANCH");

      /// FINAL VALIDATION

      bool isValidPassbook =

          (
            hasAccountNumber &&
            hasIfsc
          )

          ||

          (
            hasAccountNumber &&
            hasBankKeyword
          );

      if (isValidPassbook) {

        bankDetails.value = parsedBank;

      } else {

        bankDetails.value = null;

        /// INVALID PASSBOOK POPUP

        CommonPopup.showInvalidPopup(

          title: "Invalid Passbook",

          message:
              "No valid bank passbook was detected.\nPlease scan a clear passbook image.",

          buttonColor:
              const Color(0xff16a34a),
        );
      }

    } catch (e) {

      CommonPopup.showErrorPopup(

        title: "Error",

        message:
            "Unable to process the scanned image.",
      );

    } finally {

      isLoading.value = false;
    }
  }

  /// CLEAR DATA

  void clearData() {

    selectedImage.value = null;

    bankDetails.value = null;

    rawText.value = '';
  }
}