import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin/coin_data.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  List<DropdownMenuItem<String>> getDropdownItoms() {
    List<DropdownMenuItem<String>> dropDownItoms = [];
    // for (int i = 0; i < currenciesList.length; i++)
    for (String currency in currenciesList) {
      var newItom = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItoms.add(newItom);
    }
    return dropDownItoms;
  }

  List<Text> getPicker() {
    List<Text> pickerItoms = [];
    for (String currency in currenciesList) {
      pickerItoms.add(Text(currency));
    }
    return pickerItoms;
  }

  DropdownButton<String> getDropDownButton() {
    return DropdownButton<String>(
        value: selectedCurrency,
        items: getDropdownItoms(),
        onChanged: (value) {
          setState(() {
            selectedCurrency = value!;
          });
        });
  }

  String selectedCurrency = 'EUR';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: CupertinoPicker(
                backgroundColor: Colors.lightBlue,
                itemExtent: 32.0,
                onSelectedItemChanged: (selectedIndex) {
                  print(selectedIndex);
                },
                children: getPicker()),
          ),
        ],
      ),
    );
  }
}

// currenciesList.map((String items) {
//                   return DropdownMenuItem(value: items, child: Text(items));
//                 }).toList()

