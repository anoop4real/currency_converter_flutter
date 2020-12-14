import 'package:currencyconverterapp/APIService/web_api.dart';
import 'package:currencyconverterapp/Helpers/service_locator.dart';
import 'package:currencyconverterapp/Network/network_api.dart';
import 'package:currencyconverterapp/Network/result.dart';
import 'package:test/test.dart';

import 'Mocks/mock_network_manager.dart';

void main() {
  setUpAll(() {
    setupLocator();
    service_locator.allowReassignment = true;
  });
  test("Test if service success", () async {
    service_locator.registerLazySingleton<WebServiceApi>(
        () => MockWebService(isFailure: false));
    final _service = service_locator<ServiceApi>();
    var result = await _service.fetchExchangeRatesFor("EUR");
    service_locator.resetLazySingleton<ServiceApi>();
    expect(result.status, equals(ResultStatus.success));
  });

  test("Test if service fails", () async {
    service_locator.registerLazySingleton<WebServiceApi>(
        () => MockWebService(isFailure: true));
    final _service = service_locator<ServiceApi>();
    var result = await _service.fetchExchangeRatesFor("EUR");
    service_locator.resetLazySingleton<ServiceApi>();
    expect(result.status, equals(ResultStatus.error));
  });

  void _removeRegistrationIfExists<T>() {
    if (service_locator.isRegistered<T>()) {
      service_locator.unregister<T>();
    }
  }

  void unregisterServices() {
    _removeRegistrationIfExists<WebServiceApi>();
  }

  tearDown(() {
    unregisterServices();
  });
}
