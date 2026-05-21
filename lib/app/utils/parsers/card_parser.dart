import 'package:solu_lab_asignment/app/data/models/card_model.dart';

import '../validators/luhn_validator.dart';

class CardParser {

  static CardDetailsModel parseCard(String rawText) {

    /// CLEAN OCR TEXT

    String cleaned = rawText

        .replaceAll('O', '0')
        .replaceAll('I', '1')
        .replaceAll('S', '5');

    /// CARD NUMBER REGEX

    RegExp cardRegex = RegExp(

      r'(\d{4}\s?\d{4}\s?\d{4}\s?\d{4})',
    );

    String cardNumber = '';
    String expiryDate = '';
    String holderName = '';

    /// -----------------------------
    /// CARD NUMBER
    /// -----------------------------

    final cardMatch =
        cardRegex.firstMatch(cleaned);

    if (cardMatch != null) {

      cardNumber = cardMatch.group(0)!;

      /// REMOVE SPACES

      String cleanCard =
          cardNumber.replaceAll(" ", "");

      /// LUHN VALIDATION

      if (!LuhnValidator.isValidCard(
        cleanCard,
      )) {

        cardNumber = '';
      }
    }

    /// -----------------------------
    /// EXPIRY DATE
    /// -----------------------------
    ///
    /// PRIORITY:
    /// VALID THRU
    /// EXP
    /// EXPIRES
    ///
    /// IGNORE:
    /// VALID FROM

    RegExp validThruRegex = RegExp(

      r'(VALID\s*THRU|VALID\s*THROUGH|EXP|EXPIRES)\s*:?\s*(\d{2}[/\-]\d{2})',

      caseSensitive: false,
    );

    final expiryMatches =
        validThruRegex.allMatches(cleaned).toList();

    if (expiryMatches.isNotEmpty) {

      expiryDate =
          expiryMatches.last.group(2) ?? '';
    }

    /// FALLBACK
    /// IF KEYWORD NOT FOUND

    if (expiryDate.isEmpty) {

      RegExp fallbackRegex =
          RegExp(r'(\d{2}[/\-]\d{2})');

      final fallbackMatches =
          fallbackRegex.allMatches(cleaned).toList();

      if (fallbackMatches.isNotEmpty) {

        expiryDate =
            fallbackMatches.last.group(0) ?? '';
      }
    }

    /// -----------------------------
    /// CARD HOLDER NAME
    /// -----------------------------

    List<String> lines =
        cleaned.split('\n');

    for (var line in lines) {

      String trimmed = line.trim();

      bool isValidName =

          trimmed == trimmed.toUpperCase() &&
          trimmed.length > 4 &&
          !trimmed.contains(RegExp(r'\d'));

      bool isInvalidLine =

          trimmed.contains("VALID") ||
          trimmed.contains("THRU") ||
          trimmed.contains("VISA") ||
          trimmed.contains("MASTERCARD");

      if (isValidName && !isInvalidLine) {

        holderName = trimmed;

        break;
      }
    }

    /// RETURN MODEL

    return CardDetailsModel(

      cardNumber: cardNumber,

      expiryDate: expiryDate,

      holderName: holderName,
    );
  }
}