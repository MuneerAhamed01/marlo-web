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
      fee: map['fee'] is String
          ? double.tryParse(map['fee'])
          : map['fee'].toDouble(),
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
const mockResponse = r'''
{ "http_status_code": "200", "response": { "error_flag": "SUCCESS", "message": "List of transactions", "data": [ { "id": "ftx_xq81_k0gT8eajnAliQoCXA", "amount": "-1,000.00", "status": "PENDING", "sourceId": "1a633da1-d4b5-42e0-8c6f-01e616df73fe", "sourceType": "PAYOUT", "transactionType": "PAYOUT", "currency": "$", "createdAt": "2023-08-08T06:02:49.235000+00:00", "fee": "15", "description": "Expense", "settledAt": null, "estimatedSettledAt": "2023-08-08T00:00:00.000+00:00", "currency1": "USD" }, { "id": "ftx_mCDCfxwUStq6d2OX06Qw8g", "amount": "743.48", "status": "SETTLED", "sourceId": "3b9cca96-2e33-4a9f-84f7-43c219e59ccc", "sourceType": "CONVERSION", "transactionType": "CONVERSION_BUY", "currency": "$", "createdAt": "2023-08-08T05:57:37.835000+00:00", "fee": "-10.57", "description": "", "settledAt": "2023-08-08T05:57:37", "estimatedSettledAt": "2023-08-08T00:00:00.000+00:00", "currency1": "USD" }, { "id": "ftx_X9cUUb_KSa-UEapk5hLUKw", "amount": "-1,020.30", "status": "SETTLED", "sourceId": "3b9cca96-2e33-4a9f-84f7-43c219e59ccc", "sourceType": "CONVERSION", "transactionType": "CONVERSION_SELL", "currency": "$", "createdAt": "2023-08-08T05:57:37.735000+00:00", "fee": "0", "description": "", "settledAt": "2023-08-08T05:57:37", "estimatedSettledAt": "2023-08-08T00:00:00.000+00:00", "currency1": "SGD" }, { "id": "ftx_RLvHnDP-S5aE8RhyMBwAkA", "amount": "-739.05", "status": "PENDING", "sourceId": "609624e3-30cb-4303-9c6c-482afb1edca9", "sourceType": "PAYOUT", "transactionType": "PAYOUT", "currency": "$", "createdAt": "2023-08-08T05:57:37.706000+00:00", "fee": "15", "description": "Sample", "settledAt": null, "estimatedSettledAt": "2023-08-08T00:00:00.000+00:00", "currency1": "USD" }, { "id": "ftx_UnH7mutWQWmCCIvOI2pq0g", "amount": "743.68", "status": "SETTLED", "sourceId": "554bf335-37cf-4f9c-8348-953a47dd0a69", "sourceType": "CONVERSION", "transactionType": "CONVERSION_BUY", "currency": "$", "createdAt": "2023-08-08T05:53:51.689000+00:00", "fee": "-10.57", "description": "", "settledAt": "2023-08-08T05:53:51", "estimatedSettledAt": "2023-08-08T00:00:00.000+00:00", "currency1": "USD" }, { "id": "ftx_RNUDn5hpQ1a8g2PKMcZVJw", "amount": "-1,020.29", "status": "SETTLED", "sourceId": "554bf335-37cf-4f9c-8348-953a47dd0a69", "sourceType": "CONVERSION", "transactionType": "CONVERSION_SELL", "currency": "$", "createdAt": "2023-08-08T05:53:51.603000+00:00", "fee": "0", "description": "", "settledAt": "2023-08-08T05:53:51", "estimatedSettledAt": "2023-08-08T00:00:00.000+00:00", "currency1": "SGD" }, { "id": "ftx_L8zR8vJ4Tc2pg3UIVyZMfA", "amount": "-739.25", "status": "PENDING", "sourceId": "802708a0-17ba-4cc4-a17a-1e7994b75bd6", "sourceType": "PAYOUT", "transactionType": "PAYOUT", "currency": "$", "createdAt": "2023-08-08T05:53:51.576000+00:00", "fee": "15", "description": "Fund", "settledAt": null, "estimatedSettledAt": "2023-08-08T00:00:00.000+00:00", "currency1": "USD" }, { "id": "ftx_5T5raNDFQPaDsmxlrVFmzg", "amount": "743.73", "status": "SETTLED", "sourceId": "07e02bd6-b916-434e-87ea-4611ed637f7f", "sourceType": "CONVERSION", "transactionType": "CONVERSION_BUY", "currency": "$", "createdAt": "2023-08-08T05:45:34.466000+00:00", "fee": "-10.57", "description": "", "settledAt": "2023-08-08T05:45:34", "estimatedSettledAt": "2023-08-08T00:00:00.000+00:00", "currency1": "USD" }, { "id": "ftx_rwyCf7eTRwKtko94BiG4MA", "amount": "-1,020.29", "status": "SETTLED", "sourceId": "07e02bd6-b916-434e-87ea-4611ed637f7f", "sourceType": "CONVERSION", "transactionType": "CONVERSION_SELL", "currency": "$", "createdAt": "2023-08-08T05:45:33.891000+00:00", "fee": "0", "description": "", "settledAt": "2023-08-08T05:45:34", "estimatedSettledAt": "2023-08-08T00:00:00.000+00:00", "currency1": "SGD" }, { "id": "ftx_KvyOMCjtRYSkBVdHxfQfsg", "amount": "-739.30", "status": "PENDING", "sourceId": "c4f00f9c-81a2-4ad8-a107-10cced44b1aa", "sourceType": "PAYOUT", "transactionType": "PAYOUT", "currency": "$", "createdAt": "2023-08-08T05:45:33.867000+00:00", "fee": "15", "description": "Capital", "settledAt": null, "estimatedSettledAt": "2023-08-08T00:00:00.000+00:00", "currency1": "USD" } ] } }

''';
