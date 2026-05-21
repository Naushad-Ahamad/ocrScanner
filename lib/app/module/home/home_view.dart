import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        width: double.infinity,

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,

            colors: [
              Color(0xff0f172a),
              Color(0xff1e293b),
              Color(0xff334155),
            ],
          ),
        ),

        child: SafeArea(

          child: Padding(

            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                const SizedBox(height: 20),

                /// TITLE

                const Text(

                  "Smart OCR\nScanner",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 12),

                /// SUBTITLE

                Text(

                  "Scan cards and bank passbooks with AI-powered OCR and extract structured information instantly.",

                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 50),

                /// CARD SCANNER CARD

                GestureDetector(

                  onTap: () {
                    Get.toNamed('/card');
                  },

                  child: Container(

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

                    child: Row(

                      children: [

                        Container(

                          height: 70,
                          width: 70,

                          decoration: BoxDecoration(

                            color: Colors.blue
                                .withOpacity(0.15),

                            borderRadius:
                                BorderRadius.circular(20),
                          ),

                          child: const Icon(
                            Icons.credit_card,
                            color: Colors.blue,
                            size: 36,
                          ),
                        ),

                        const SizedBox(width: 18),

                        Expanded(

                          child: Column(

                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [

                              const Text(

                                "Card Scanner",

                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(

                                "Scan debit or credit cards and automatically extract card number, expiry date, and holder name.",

                                style: TextStyle(
                                  color: Colors.white
                                      .withOpacity(0.7),

                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 10),

                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                /// PASSBOOK SCANNER CARD

                GestureDetector(

                  onTap: () {
                    Get.toNamed('/passbook');
                  },

                  child: Container(

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

                    child: Row(

                      children: [

                        Container(

                          height: 70,
                          width: 70,

                          decoration: BoxDecoration(

                            color: Colors.green
                                .withOpacity(0.15),

                            borderRadius:
                                BorderRadius.circular(20),
                          ),

                          child: const Icon(
                            Icons.account_balance,
                            color: Colors.green,
                            size: 36,
                          ),
                        ),

                        const SizedBox(width: 18),

                        Expanded(

                          child: Column(

                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [

                              const Text(

                                "Passbook Scanner",

                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(

                                "Extract account holder name, account number, and IFSC code from passbooks or bank documents.",

                                style: TextStyle(
                                  color: Colors.white
                                      .withOpacity(0.7),

                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 10),

                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                /// FOOTER

                Center(

                  child: Text(

                    "Built with Flutter • GetX • ML Kit OCR",

                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}