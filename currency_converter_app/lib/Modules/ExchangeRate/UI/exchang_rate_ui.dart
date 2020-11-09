import 'package:currencyconverterapp/Helpers/service_locator.dart';
import 'package:currencyconverterapp/Helpers/view_state.dart';
import 'package:currencyconverterapp/Modules/ExchangeRate/ViewModel/exchange_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExchangeRateUI extends StatefulWidget {
  @override
  _ExchangeRateUIState createState() => _ExchangeRateUIState();
}
// TODO: Add BaseView
class _ExchangeRateUIState extends State<ExchangeRateUI> {
  ExchangeViewModel _viewModel = service_locator<ExchangeViewModel>();
  List<String> _currencies = [
    'EUR',
    'INR',
    'CAD',
    'DER'
  ]; // TODO: Use viewmodel
  String _dropDownValue = 'EUR'; // TODO: Use viewmodel
  final TextEditingController _amountTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _amountTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildView(context);
  }

  Widget _buildView(BuildContext context) {
    return ChangeNotifierProvider<ExchangeViewModel>(
      create: (context) => _viewModel,
      child: Consumer<ExchangeViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text('Exchange Currency'),
          ),
          body: Container(
              child: model.state == ViewState.Busy
                  ? Center(child: CircularProgressIndicator())
                  : _buildColumn(model)),
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
                fetchCurrenciesWith(model)
              },
            ),
          );
  }

  //
  Widget _buildColumn(ExchangeViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          _buildAmountInputRow(),
          const SizedBox(
            height: 10.0,
          ),
          Expanded(child: _buildList(viewModel))
        ],
      ),
    );
  }

  Widget _buildTextFieldWith(
      TextEditingController controller, String hintText) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(left: 0, bottom: 0, top: 0, right: 0),
          labelText: hintText,
        ));
  }

  // TODO: Use viewmodel
  Widget _buildDropDown() {
    return DropdownButton<String>(
      value: _dropDownValue,
      icon: Icon(Icons.arrow_drop_down),
      elevation: 16,
      items: _currencies.map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        // TODO: Revisit
        _viewModel.fetchCurrencyRatesFor(newValue);
        setState(() {
          _dropDownValue = newValue;
        });
      },
    );
  }

  Widget _buildAmountInputRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: _buildTextFieldWith(
              _amountTextController, 'Enter amount to convert'),
        ),
        _buildDropDown()
      ],
    );
  }

  void fetchCurrenciesWith(ExchangeViewModel model) {

    model.fetchCurrencyRatesFor(_dropDownValue).then((result) {
      if (!result) {
        _showDialog();
      }
    });
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