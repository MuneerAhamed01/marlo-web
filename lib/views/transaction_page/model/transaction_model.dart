class TransactionModel {
  final String id;
  final String amount;
  final String status;
  final String sourceId;
  final String transactionType;
  final String currency;
  final DateTime createdAt;
  final double? fee;
  final String description;
  final DateTime? settledAt;
  final DateTime? estimatedSettledAt;
  final String currency1;
  final String sourceType;
  TransactionModel({
    required this.id,
    required this.amount,
    required this.status,
    required this.sourceId,
    required this.transactionType,
    required this.currency,
    required this.createdAt,
    required this.fee,
    required this.description,
    required this.settledAt,
    required this.estimatedSettledAt,
    required this.currency1,
    required this.sourceType,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] ?? '',
      amount: map['amount'] ?? '',
      status: map['status'] ?? '',
      sourceId: map['sourceId'] ?? '',
      transactionType: map['transactionType'] ?? '',
      currency: map['currency'] ?? '',
      createdAt: _stringToDateTime(map['createdAt'])!,
      fee: map['fee']?.toDouble() ?? 0.0,
      description: map['description'] ?? '- -',
      settledAt: _stringToDateTime(map['settledAt']),
      estimatedSettledAt: _stringToDateTime(map['estimatedSettledAt']),
      currency1: map['currency1'] ?? '',
      sourceType: map['sourceType'],
    );
  }

  static DateTime? _stringToDateTime(String? date) =>
      date != null ? DateTime.tryParse(date) : null;

  // static SourceType _sourceType(String type) {
  //   return SourceType.values.firstWhereOrNull(
  //           (element) => element.name.toLowerCase() == type.toLowerCase()) ??
  //       SourceType.others;
  // }

  @override
  String toString() {
    return 'TransactionModel(id: $id, amount: $amount, status: $status, sourceId: $sourceId, transactionType: $transactionType, currency: $currency, createdAt: $createdAt, fee: $fee, description: $description, settledAt: $settledAt, estimatedSettledAt: $estimatedSettledAt, currency1: $currency1)';
  }
}
