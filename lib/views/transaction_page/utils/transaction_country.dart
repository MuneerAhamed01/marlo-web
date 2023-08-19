import 'package:sample/utils/flags.dart';

class TransactionByCountry {
  final String? flag;
  final String name;
  final String amount;
  final String sub;

  TransactionByCountry({
    this.flag,
    required this.name,
    required this.amount,
    required this.sub,
  });
}

List<TransactionByCountry> getTransactionCountry() => [
      TransactionByCountry(
        flag: CountryFlags.gpb,
        name: 'GBP',
        amount: '15,256,486.00',
        sub: 'Main',
      ),
      TransactionByCountry(
        flag: CountryFlags.usd,
        name: 'USD',
        amount: '0.00',
        sub: 'Salary',
      ),
      TransactionByCountry(
        name: 'EUR',
        amount: '0.00',
        sub: 'Salary',
      ),
      TransactionByCountry(
        name: 'EUR',
        amount: '0.00',
        sub: 'Shipping',
      ),
      TransactionByCountry(
        name: 'SGD',
        amount: '15,256,486.00',
        sub: 'Salary',
      ),
      TransactionByCountry(
        name: 'SGD',
        amount: '15,256,486.00',
        sub: 'Salary',
      ),
    ];
List<String> get currencies => ["SGD", "USD", "EUR", "GBP"];
