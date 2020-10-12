
import 'package:currencyconverterapp/Modules/ExchangeRate/Model/Rate.dart';

abstract class ServiceApi {
  Future<Rate> fetchExchangeRatesFor(String baseCurrency);
}
