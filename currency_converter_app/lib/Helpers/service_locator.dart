import 'package:currencyconverterapp/APIService/web_api.dart';
import 'package:currencyconverterapp/Modules/ExchangeRate/Service/exchange_service.dart';
import 'package:currencyconverterapp/Modules/ExchangeRate/ViewModel/exchange_view_model.dart';
import 'package:currencyconverterapp/Network/networkAPI.dart';
import 'package:currencyconverterapp/Network/networkDataManager.dart';
import 'package:get_it/get_it.dart';

import 'APIConstants.dart';

GetIt service_locator = GetIt.instance;

void setupLocator() {

  service_locator.registerFactory<WebServiceApi>(() => NetworkDataManager(APIBaseURL));
  service_locator.registerLazySingleton<ServiceApi>(() => ExchangeRateService());
  service_locator.registerFactory(() => ExchangeViewModel());


}