import 'package:solu_lab_asignment/app/data/models/bank_model.dart';

class PassbookParser {

  static BankDetailsModel parsePassbook(String rawText) {

    /// =====================================
    /// CLEAN OCR TEXT
    /// =====================================

    String cleaned = rawText

        .toUpperCase()

        .replaceAll('O', '0')
        .replaceAll('|', '1')
        .replaceAll('S', '5');

    String accountNumber = '';
    String ifscCode = '';
    String accountName = '';

    /// =====================================
    /// ACCOUNT NUMBER EXTRACTION
    /// =====================================

    List<RegExp> accountRegexList = [

      /// ACCOUNT NO : 1234567890

      RegExp(
        r'(?:ACCOUNT|ACC|A\/C|ACCT)[\s\.\-]*(?:NO|NUMBER|#)?[\s\:\-]*([0-9\-\s]{9,25})',
      ),

      /// हिंदी FORMAT

      RegExp(
        r'(?:खाता|खाता संख्या|अकाउंट नंबर)[\s\:\-]*([0-9\-\s]{9,25})',
      ),

      /// fallback

      RegExp(
        r'\b([0-9][0-9\-\s]{8,20}[0-9])\b',
      ),
    ];

    for (var regex in accountRegexList) {

      final matches =
          regex.allMatches(cleaned).toList();

      if (matches.isNotEmpty) {

        for (var match in matches) {

          String extracted =
              match.group(1) ?? '';

          extracted = extracted

              .replaceAll(' ', '')
              .replaceAll('-', '');

          /// VALID ACCOUNT NUMBER LENGTH

          if (extracted.length >= 9 &&
              extracted.length <= 20) {

            accountNumber = extracted;

            break;
          }
        }
      }

      if (accountNumber.isNotEmpty) {
        break;
      }
    }

    /// =====================================
    /// IFSC CODE EXTRACTION
    /// =====================================

    /// REMOVE SPACES

    String ifscCleaned = cleaned

        .replaceAll(' ', '')

        /// COMMON OCR FIXES

        .replaceAll('O', '0');

    /// SUPPORTS:
    ///
    /// IFSC : SBIN0001234
    /// IFSC CODE : SBIN0001234
    /// SBIN 0001234
    /// HDFC0001234
    /// PUNB0123456
    /// ICIC0001234
    /// BARB0XXXXXX
    /// ALL BANK FORMATS

    List<RegExp> ifscRegexList = [

      /// WITH IFSC LABEL

      RegExp(
        r'IFSC(?:CODE)?[:\-]?([A-Z]{4}0[A-Z0-9]{6})',
      ),

      /// हिंदी FORMAT

      RegExp(
        r'आईएफएससी[:\-]?([A-Z]{4}0[A-Z0-9]{6})',
      ),

      /// GENERAL IFSC FORMAT

      RegExp(
        r'\b([A-Z]{4}0[A-Z0-9]{6})\b',
      ),
    ];

    for (var regex in ifscRegexList) {

      final matches =
          regex.allMatches(ifscCleaned).toList();

      if (matches.isNotEmpty) {

        ifscCode =
            matches.first.group(1) ?? '';

        break;
      }
    }

    /// =====================================
    /// ACCOUNT HOLDER NAME
    /// =====================================

    List<String> lines =
        cleaned.split('\n');

    for (var line in lines) {

      String trimmed = line.trim();

      trimmed = trimmed.replaceAll(
        RegExp(r'\s+'),
        ' ',
      );

      /// IGNORE SHORT TEXT

      if (trimmed.length < 5) continue;

      /// IGNORE NUMBER LINES

      if (trimmed.contains(RegExp(r'\d'))) {
        continue;
      }

      /// IGNORE INVALID WORDS

      bool invalidLine =

          trimmed.contains('BANK') ||
          trimmed.contains('BRANCH') ||
          trimmed.contains('IFSC') ||
          trimmed.contains('ACCOUNT') ||
          trimmed.contains('A/C') ||
          trimmed.contains('ADDRESS') ||
          trimmed.contains('MICR') ||
          trimmed.contains('INDIA') ||
          trimmed.contains('STATEMENT') ||
          trimmed.contains('CUSTOMER') ||
          trimmed.contains('DETAILS') ||
          trimmed.contains('PASSBOOK') ||
          trimmed.contains('SAVINGS') ||
          trimmed.contains('CURRENT') ||
          trimmed.contains('CODE');

      if (invalidLine) continue;

      /// VALID ENGLISH NAME

      bool englishName =

          RegExp(r'^[A-Z\s\.]+$')
              .hasMatch(trimmed);

      /// VALID HINDI NAME

      bool hindiName =

          RegExp(r'^[\u0900-\u097F\s]+$')
              .hasMatch(trimmed);

      if (englishName || hindiName) {

        accountName = trimmed;

        break;
      }
    }

    /// =====================================
    /// RETURN MODEL
    /// =====================================

    return BankDetailsModel(

      accountName: accountName,

      accountNumber: accountNumber,

      ifscCode: ifscCode,
    );
  }
}