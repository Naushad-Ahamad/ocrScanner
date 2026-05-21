import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonPopup {

  /// ERROR POPUP

  static void showErrorPopup({

    required String title,
    required String message,
  }) {

    Get.dialog(

      Dialog(

        backgroundColor: const Color(0xff1e293b),

        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(24),
        ),

        child: Padding(

          padding: const EdgeInsets.all(24),

          child: Column(

            mainAxisSize: MainAxisSize.min,

            children: [

              const Icon(

                Icons.error_outline,

                color: Colors.red,

                size: 50,
              ),

              const SizedBox(height: 20),

              Text(

                title,

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Text(

                message,

                textAlign: TextAlign.center,

                style: TextStyle(
                  color:
                      Colors.white.withOpacity(0.7),

                  fontSize: 15,

                  height: 1.5,
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(

                width: double.infinity,
                height: 50,

                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(

                    backgroundColor:
                        const Color(0xff2563eb),

                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                  ),

                  onPressed: () {
                    Get.back();
                  },

                  child: const Text(

                    "OK",

                    style: TextStyle(
                      color: Colors.white,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// INVALID DOCUMENT POPUP

  static void showInvalidPopup({

    required String title,
    required String message,
    Color buttonColor =
        const Color(0xff2563eb),
  }) {

    Get.dialog(

      Dialog(

        backgroundColor: const Color(0xff1e293b),

        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(24),
        ),

        child: Padding(

          padding: const EdgeInsets.all(24),

          child: Column(

            mainAxisSize: MainAxisSize.min,

            children: [

              Container(

                height: 80,
                width: 80,

                decoration: BoxDecoration(

                  color:
                      Colors.red.withOpacity(0.15),

                  shape: BoxShape.circle,
                ),

                child: const Icon(

                  Icons.warning_amber_rounded,

                  color: Colors.red,

                  size: 45,
                ),
              ),

              const SizedBox(height: 24),

              Text(

                title,

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 14),

              Text(

                message,

                textAlign: TextAlign.center,

                style: TextStyle(
                  color:
                      Colors.white.withOpacity(0.7),

                  fontSize: 15,

                  height: 1.6,
                ),
              ),

              const SizedBox(height: 28),

              SizedBox(

                width: double.infinity,
                height: 52,

                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(

                    backgroundColor:
                        buttonColor,

                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),

                  onPressed: () {
                    Get.back();
                  },

                  child: const Text(

                    "Try Again",

                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}