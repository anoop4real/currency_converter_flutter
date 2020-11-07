import 'dart:async';

import '../../../APIService/web_api.dart';
import '../../../Helpers/service_locator.dart';
import '../../../Helpers/view_state.dart';
import '../../../Modules/ExchangeRate/Model/rate.dart';
import '../../../Modules/ExchangeRate/Service/exchange_service.dart';

import 'base_view_model.dart';

class ExchangeViewModel extends BaseViewModel {
  final ExchangeRateService _exchangeRateService =
      service_locator<ServiceApi>();
  Rate rate;


  Future<bool> fetchCurrencyRatesFor(String currencyText) {
    setState(ViewState.Busy);
    final completer = Completer<bool>();
    _exchangeRateService.fetchExchangeRatesFor(currencyText).then((result) {
      // TODO: Change to Result Type
      if (result != null) {
        rate = result;
        completer.complete(true);
      } else {
        // TODO: Error
        completer.complete(false);
      }
      setState(ViewState.Idle);
    });
    return completer.future;
  }
}
