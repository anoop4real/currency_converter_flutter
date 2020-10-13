import 'package:currencyconverterapp/Helpers/service_locator.dart';
import 'package:currencyconverterapp/Helpers/view_state.dart';
import 'package:currencyconverterapp/Modules/ExchangeRate/ViewModel/exchange_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExchangeRateUI extends StatefulWidget {
  @override
  _ExchangeRateUIState createState() => _ExchangeRateUIState();
}

class _ExchangeRateUIState extends State<ExchangeRateUI> {
  final viewModel = ExchangeViewModel();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildView(context);
  }

  Widget _buildSimpleFetch() {
    return Container(
      child: RaisedButton(
        child: Text("Fetch"),
        onPressed: () => {viewModel.fetchCurrencyRatesFor("EUR")},
      ),
    );
  }

  Widget _buildView(BuildContext context) {
    return ChangeNotifierProvider<ExchangeViewModel>(
      create: (context) => service_locator<ExchangeViewModel>(),
      child: Consumer<ExchangeViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text('Exchange Currency'),
          ),
          body: Container(
              child: model.state == ViewState.Busy
                  ? Center(child: CircularProgressIndicator())
                  : _buildList(model)),
        ),
      ),
    );
  }

  Widget _buildList(ExchangeViewModel model) {
    return (model.rate != null && model.rate.rates != null)
        ? ListView.builder(
            itemCount: model.rate.rates.keys.toList().length,
            itemBuilder: (BuildContext context, int index) {
              var itemKey = model.rate.rates.keys.toList()[index];
              var itemValue = model.rate.rates[itemKey] as double;
              return ListTile(
                title: Text(itemKey),
                trailing: Text(itemValue.toString()),
              );
            },
          )
        : Center(
            child: RaisedButton(
              child: Text("Fetch"),
              onPressed: () => {
                model.fetchCurrencyRatesFor("EUR").then((result) {
                  if (!result) {
                    _showDialog();
                  }
                })
              },
            ),
          );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text("Failed To Fetch"),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
