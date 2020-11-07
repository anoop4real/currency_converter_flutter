
import 'package:currencyconverterapp/Modules/ExchangeRate/Model/rate.dart';

abstract class ServiceApi {
  Future<Rate> fetchExchangeRatesFor(String baseCurrency);
}
