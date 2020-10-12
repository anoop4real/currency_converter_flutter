import 'package:currencyconverterapp/Modules/ExchangeRate/ViewModel/exchange_view_model.dart';
import 'package:flutter/material.dart';

class ExhangeRateUI extends StatefulWidget {
  @override
  _ExhangeRateUIState createState() => _ExhangeRateUIState();
}

class _ExhangeRateUIState extends State<ExhangeRateUI> {
  final viewModel = ExchangeViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        child: Text("Fetch"),
        onPressed: () => {
          viewModel.fetchCurrencyRatesFor("EUR")
        },
      ),
    );
  }
}
