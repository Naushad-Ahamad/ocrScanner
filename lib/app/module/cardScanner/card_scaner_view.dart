import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:solu_lab_asignment/app/module/cardScanner/card_scaner_controller.dart';

class CardScannerView extends GetView<CardScannerController> {

  const CardScannerView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xff0f172a),

      appBar: AppBar(

        elevation: 0,

        backgroundColor: const Color(0xff0f172a),

        centerTitle: true,

        title: const Text(

          "Card Scanner",

          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Obx(() {

        return SingleChildScrollView(

          child: Padding(

            padding: const EdgeInsets.all(20),

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                /// HEADER

                const Text(

                  "Smart Card\nRecognition",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 12),

                Text(

                  "Scan debit or credit cards using AI-powered OCR and automatically extract important card details securely.",

                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 35),

                /// SINGLE SCAN BUTTON

                SizedBox(

                  width: double.infinity,
                  height: 58,

                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(

                      backgroundColor:
                          const Color(0xff2563eb),

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(18),
                      ),
                    ),

                    onPressed: () {

                      Get.bottomSheet(

                        Container(

                          padding: const EdgeInsets.all(20),

                          decoration: const BoxDecoration(

                            color: Color(0xff1e293b),

                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),

                          child: Column(

                            mainAxisSize: MainAxisSize.min,

                            children: [

                              Container(

                                width: 50,
                                height: 5,

                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius:
                                      BorderRadius.circular(10),
                                ),
                              ),

                              const SizedBox(height: 25),

                              const Text(

                                "Choose Scan Option",

                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 25),

                              /// CAMERA OPTION

                              ListTile(

                                onTap: () {

                                  Get.back();

                                  controller
                                      .scanCardFromCamera();
                                },

                                leading: Container(

                                  padding:
                                      const EdgeInsets.all(12),

                                  decoration: BoxDecoration(

                                    color: Colors.blue
                                        .withOpacity(0.15),

                                    borderRadius:
                                        BorderRadius.circular(14),
                                  ),

                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.blue,
                                  ),
                                ),

                                title: const Text(

                                  "Camera",

                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight:
                                        FontWeight.w600,
                                  ),
                                ),

                                subtitle: Text(

                                  "Capture live card image",

                                  style: TextStyle(
                                    color: Colors.white
                                        .withOpacity(0.6),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),

                              /// GALLERY OPTION

                              ListTile(

                                onTap: () {

                                  Get.back();

                                  controller
                                      .scanCardFromGallery();
                                },

                                leading: Container(

                                  padding:
                                      const EdgeInsets.all(12),

                                  decoration: BoxDecoration(

                                    color: Colors.cyan
                                        .withOpacity(0.15),

                                    borderRadius:
                                        BorderRadius.circular(14),
                                  ),

                                  child: const Icon(
                                    Icons.photo_library_outlined,
                                    color: Colors.cyan,
                                  ),
                                ),

                                title: const Text(

                                  "Gallery",

                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight:
                                        FontWeight.w600,
                                  ),
                                ),

                                subtitle: Text(

                                  "Choose image from gallery",

                                  style: TextStyle(
                                    color: Colors.white
                                        .withOpacity(0.6),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      );
                    },

                    child: const Row(

                      mainAxisAlignment:
                          MainAxisAlignment.center,

                      children: [

                        Icon(
                          Icons.document_scanner_outlined,
                          color: Colors.white,
                        ),

                        SizedBox(width: 10),

                        Text(

                          "Scan Card",

                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                /// LOADING

                if (controller.isLoading.value)

                  const Center(
                    child: CircularProgressIndicator(),
                  ),

                /// IMAGE PREVIEW

                if (controller.selectedImage.value != null)

                  Container(

                    width: double.infinity,
                    height: 220,

                    decoration: BoxDecoration(

                      borderRadius:
                          BorderRadius.circular(24),

                      boxShadow: [

                        BoxShadow(

                          color:
                              Colors.black.withOpacity(0.3),

                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),

                    child: ClipRRect(

                      borderRadius:
                          BorderRadius.circular(24),

                      child: Image.file(

                        File(
                          controller
                              .selectedImage
                              .value!
                              .path,
                        ),

                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                const SizedBox(height: 30),

                /// RESULT CARD

                if (controller.cardDetails.value != null)

                  Container(

                    width: double.infinity,

                    padding: const EdgeInsets.all(22),

                    decoration: BoxDecoration(

                      borderRadius:
                          BorderRadius.circular(24),

                      color: Colors.white.withOpacity(0.08),

                      border: Border.all(
                        color:
                            Colors.white.withOpacity(0.1),
                      ),
                    ),

                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        const Row(

                          children: [

                            Icon(
                              Icons.verified,
                              color: Colors.green,
                            ),

                            SizedBox(width: 10),

                            Text(

                              "Extracted Details",

                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 25),

                        /// MASKED CARD NUMBER

                        _buildInfoCard(

                          title: "Card Number",

                          value: maskCardNumber(
                            controller.cardDetails
                                .value!
                                .cardNumber,
                          ),

                          icon: Icons.credit_card,
                        ),

                        const SizedBox(height: 16),

                        /// EXPIRY

                        _buildInfoCard(

                          title: "Expiry Date",

                          value: controller
                              .cardDetails
                              .value!
                              .expiryDate,

                          icon: Icons.calendar_month,
                        ),

                        const SizedBox(height: 16),

                        /// HOLDER NAME

                        _buildInfoCard(

                          title: "Card Holder",

                          value: controller
                              .cardDetails
                              .value!
                              .holderName,

                          icon: Icons.person,
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 40),

                Center(

                  child: Text(

                    "Secure OCR Extraction • Flutter • GetX",

                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  /// MASK CARD NUMBER

  String maskCardNumber(String cardNumber) {

    String cleaned =
        cardNumber.replaceAll(' ', '');

    if (cleaned.length < 4) {
      return cardNumber;
    }

    String last4 =
        cleaned.substring(cleaned.length - 4);

    return "XXXX XXXX XXXX $last4";
  }

  Widget _buildInfoCard({

    required String title,
    required String value,
    required IconData icon,
  }) {

    return Container(

      width: double.infinity,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(

        color: Colors.white.withOpacity(0.05),

        borderRadius:
            BorderRadius.circular(18),
      ),

      child: Row(

        children: [

          Container(

            height: 50,
            width: 50,

            decoration: BoxDecoration(

              color:
                  const Color(0xff2563eb).withOpacity(0.2),

              borderRadius:
                  BorderRadius.circular(14),
            ),

            child: Icon(
              icon,
              color: const Color(0xff60a5fa),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(

                  title,

                  style: TextStyle(
                    color:
                        Colors.white.withOpacity(0.6),
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 6),

                Text(

                  value.isEmpty
                      ? "Not Detected"
                      : value,

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}