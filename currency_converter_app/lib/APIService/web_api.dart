
import 'package:currencyconverterapp/Exceptions/app_exceptions.dart';
import 'package:currencyconverterapp/Modules/ExchangeRate/Model/rate.dart';
import 'package:currencyconverterapp/Network/result.dart';

abstract class ServiceApi {
  Future<Result<Rate, ApplicationException>> fetchExchangeRatesFor(String baseCurrency);
}
