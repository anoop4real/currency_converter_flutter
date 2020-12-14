import 'package:currencyconverterapp/APIService/web_api.dart';
import 'package:currencyconverterapp/Helpers/service_locator.dart';
import 'package:currencyconverterapp/Network/network_api.dart';
import 'package:currencyconverterapp/Network/result.dart';
import 'package:test/test.dart';

import 'Mocks/mock_exchange_service.dart';
import 'Mocks/mock_network_manager.dart';

void main() {
  setUpAll((){
    setupLocator();
    service_locator.allowReassignment = true;
  });
  test("Test if service success", () async {
    service_locator.registerLazySingleton<WebServiceApi>(() => MockWebService());
    final _service = service_locator<ServiceApi>();
    var result = await _service.fetchExchangeRatesFor("EUR");
    expect(result.status, equals(ResultStatus.success));
  });
}