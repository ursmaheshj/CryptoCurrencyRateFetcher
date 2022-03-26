import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin/coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'INR';

  Map<String, String> cryptoPrices = {};

  bool isWaiting = false;

  void getCryptoData() async {
    isWaiting = true;
    try {
      var priceData = await CoinData().fetchRateData(selectedCurrency);
      isWaiting = false;
      setState(() {
        cryptoPrices = priceData;
      });
    } catch (e) {
      print(e);
    }
  }

  DropdownButton<String> getAndroidDropdownButton() {
    List<DropdownMenuItem<String>> dropDownItoms = [];
    for (String currency in currenciesList) {
      var newItom = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItoms.add(newItom);
    }

    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropDownItoms,
        onChanged: (value) async {
          setState(() {
            selectedCurrency = value!;
            getCryptoData();
          });
        });
  }

  CupertinoPicker getIOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          setState(() {
            selectedCurrency = currenciesList[selectedIndex];
            getCryptoData();
          });
        },
        children: pickerItems);
  }

  getPicker() {
    if (Platform.isIOS) {
      return getIOSPicker();
    } else if (Platform.isAndroid) {
      return getAndroidDropdownButton();
    }
  }

  Column makeCryptoCards() {
    List<CryptoCard> cryptoCards = [];
    for (String crypto in cryptoList) {
      cryptoCards.add(CryptoCard(
        cryptoCurrency: crypto,
        rate: isWaiting ? '?' : cryptoPrices[crypto],
        selectedCurrency: selectedCurrency,
      ));
    }
    return Column(
      children: cryptoCards,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCryptoData();
  }

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
          makeCryptoCards(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid
                ? getIOSPicker()
                : getAndroidDropdownButton(),
          )
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key? key,
    required this.cryptoCurrency,
    required this.rate,
    required this.selectedCurrency,
  }) : super(key: key);

  final String cryptoCurrency;
  final String? rate;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $rate $selectedCurrency',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// currenciesList.map((String items) {
//                   return DropdownMenuItem(value: items, child: Text(items));
//                 }).toList()


