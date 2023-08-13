enum TransactionStatus { processing, processed }

class MarloTableColumn {
  final String name;
  final String amount;
  final TransactionStatus status;
  final String source;
  final DateTime createdBy;

  MarloTableColumn({
    required this.name,
    required this.amount,
    required this.status,
    required this.source,
    required this.createdBy,
  });
}
