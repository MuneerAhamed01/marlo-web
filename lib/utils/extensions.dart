import 'package:sample/utils/enums.dart';

extension SourceTypeIdentifier on SourceType {
  List<String> get values => [
        if (this == SourceType.credit) ...[
          'DEPOSIT',
          'TRANSFER',
          "REFUND"
        ] else if (this == SourceType.debit) ...[
          'PAYOUT',
          "CHARGE",
          "PAYMENT_ATTEMPT",
          "FEE"
        ] else if (this == SourceType.conversion)
          "CONVERSION"
      ];
}
