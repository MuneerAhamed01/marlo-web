import 'base_service.dart';

class TransactionService {
  TransactionService._();
  static TransactionService get instance => TransactionService._();
  final BaseService _base = BaseService.instance;

  Future<void> getTransaction() async {
    final response = await _base.get(
      'https://asia-southeast1-marlo-bank-dev.cloudfunctions.net/api_dev/v2/airwallex/995b1e2e-c5ac-417b-afe5-1de5e92f4cf3/transfers',
    );

    print(response.data);
  }
}
