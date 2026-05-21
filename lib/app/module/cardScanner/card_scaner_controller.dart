import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:solu_lab_asignment/app/common/common_popup.dart';
import 'package:solu_lab_asignment/app/data/models/card_model.dart';
import 'package:solu_lab_asignment/app/data/services/ocr_service.dart';
import 'package:solu_lab_asignment/app/utils/parsers/card_parser.dart';

class CardScannerController extends GetxController {
  /// SELECTED IMAGE

  Rx<File?> selectedImage = Rx<File?>(null);

  /// LOADING

  RxBool isLoading = false.obs;

  /// CARD DETAILS

  Rx<CardDetailsModel?> cardDetails = Rx<CardDetailsModel?>(null);

  /// RAW OCR TEXT

  RxString rawText = ''.obs;

  /// CAMERA SCAN

  Future<void> scanCardFromCamera() async {
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

        message: "Something went wrong while opening the camera.",
      );
    }
  }

  /// GALLERY SCAN

  Future<void> scanCardFromGallery() async {
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

        message: "Something went wrong while selecting image.",
      );
    }
  }

  /// PROCESS IMAGE

  Future<void> processImage(String path) async {
    try {
      selectedImage.value = File(path);

      isLoading.value = true;

      /// OCR TEXT EXTRACTION

      final extractedText = await OCRService.extractText(selectedImage.value!);

      rawText.value = extractedText;

      /// PARSE CARD

      final parsedCard = CardParser.parseCard(extractedText);

      /// VALID CARD CHECK

      bool hasValidCard =
          parsedCard.cardNumber.isNotEmpty && parsedCard.expiryDate.isNotEmpty;

      if (hasValidCard) {
        cardDetails.value = parsedCard;
      } else {
        /// CLEAR INVALID DATA

        cardDetails.value = null;

        /// INVALID CARD POPUP

        CommonPopup.showInvalidPopup(
          title: "Invalid Card",

          message:
              "No valid debit or credit card was detected.\nPlease scan a clear image of a card.",
        );
      }
    } catch (e) {
      CommonPopup.showErrorPopup(
        title: "Error",

        message: "Unable to process the scanned image.",
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// CLEAR DATA

  void clearData() {
    selectedImage.value = null;

    cardDetails.value = null;

    rawText.value = '';
  }
}
